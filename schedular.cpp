#include "schedular.h"
#include <algorithm>

#include <QVariant>
#include <QList>

#include <QDebug>

Schedular::Schedular(QObject *parent): QObject{parent},
    m_algorithmId{FCFS}, m_preemptive{false}, m_quanta{0},
    m_currentTime(0), m_currentProcess{0, 0, 0, 0},
    m_running{false}, m_paused{false}, m_idle{true},
    m_isArrivingQueueEmpty(true), m_totalWaitingTime{0}, m_averageWaitingTime{0}, m_idleTime{0}
{
    connect(&m_timer, SIGNAL(timeout()), this, SLOT(step()));

    m_processComparator =  [](const Process &p1, const Process &p2){
        return p1.m_arrivalTime < p2.m_arrivalTime;
    };
}

int Schedular::enqueueArrivedProccess(const Process &process)
{
    if(process.m_arrivalTime > m_currentTime)
    {
        return -1;
    }

    if(process.m_pid == m_currentProcess.m_pid)
    {
        if(m_algorithmId == AlgorithmId::RR)
        {
            m_readyQueue.insert(m_readyQueue.count(), process);
            return m_readyQueue.count() -1;
        }
        else
        {
            m_readyQueue.insert(1, process);
            return 1;
        }
    }

    std::vector<Process>::reverse_iterator itr;

    long long index = 0;

    std::function<bool(const Process &)> searchFunc = std::bind(m_processComparator, process, std::placeholders::_1);

    if(m_algorithmId == SJF) //SJF
    {
        index = std::find_if(m_readyQueue.begin(), m_readyQueue.end(), searchFunc) - m_readyQueue.begin();
    }

    else if(m_algorithmId == PRIORITY) //Priority
    {
        index = std::find_if(m_readyQueue.begin(), m_readyQueue.end(), searchFunc) - m_readyQueue.begin();
    }

    else //FCFS, RR
    {
        index = std::find_if(m_readyQueue.begin(), m_readyQueue.end(), searchFunc) - m_readyQueue.begin();
    }

    m_readyQueue.insert(static_cast<int>(index), process);
    return index;
}

void Schedular::reset()
{
    m_readyQueue.clear();
    m_finishedProcesses.clear();
    m_gantChart.clear();
    setCurrentTime(0);
    setPaused(false);

    m_totalWaitingTime = 0;
    m_totalResponseTime = 0;
    m_totalTurnaroundTime = 0;

    setAverageWaitingTime(0);
    setAverageResponseTime(0);
    setAverageTurnaroundTime(0);
    setIdleTime(0);

    m_currentQuanta = m_quanta;
}


void Schedular::startSolving()
{
    m_timer.start(m_delay);
}

void Schedular::solve()
{
    setRunning(true);
    m_timer.start(m_delay);
    startSolving();
    while(step())
    {
    }
}

bool Schedular::step()
{
    if(!m_running)
    {
        reset();
        setRunning(true);
        runReadyProcess();
    }

    if(m_paused)
    {
        return true;
    }

    if(m_currentProcess.m_duration || (!m_readyQueue.empty()))
    {
        setIdle(false);

        setCurrentTime(m_currentTime +1);

        --m_currentProcess.m_duration;
        emit currentProcessDataChanged();

        --m_currentQuanta;
    }
    else if (!m_isArrivingQueueEmpty)
    {
        setIdle(true);
        setIdleTime(m_idleTime +1);

        setCurrentProcess(Process());

        if(m_gantChart.last().id != 0)
        {
            m_gantChart.push_back({m_currentProcess.m_pid, m_currentTime});
            emit gantChartChanged();
        }

        setCurrentTime(m_currentTime +1);
    }
    else
    {
        m_timer.stop();
        setRunning(false);
        setIdle(true);
        return false;
    }

    if(m_currentProcess.m_duration == 0 || (m_algorithmId != AlgorithmId::RR && m_preemptive && (m_readyQueue.empty() ? false : m_processComparator(m_readyQueue.first(), m_currentProcess))))
    {
        stopCurrentProcess();
        runReadyProcess();
    }

    else if(m_algorithmId == AlgorithmId::RR && m_currentQuanta == 0)
    {
        if(m_readyQueue.empty())
        {
            m_currentQuanta = m_quanta;
        }
        else
        {
            stopCurrentProcess();
            runReadyProcess();
        }
    }
    return true;
}


void Schedular::runReadyProcess()
{
    if(m_readyQueue.empty())
        return;


    setCurrentProcess(m_readyQueue.takeFirst());

    emit readyQueuePoped();

    if(m_currentProcess.m_duration == m_currentProcess.m_originalDuration)
        m_currentProcess.m_startedTime  = m_currentTime;

    m_currentProcess.m_state = Process::State::running;

    m_gantChart.push_back({m_currentProcess.m_pid, m_currentTime});
    emit gantChartChanged();

    m_currentQuanta = m_quanta;
}

void Schedular::stopCurrentProcess()
{
    if(m_currentProcess.m_pid == 0)
    {
        return;
    }
    if(m_currentProcess.m_duration == 0)
    {
        m_currentProcess.m_finishedTime = m_currentTime;
        m_currentProcess.m_state = Process::State::finished;
        m_currentProcess.m_turnaroundTime = m_currentProcess.m_finishedTime - m_currentProcess.m_arrivalTime;
        m_currentProcess.m_waitingTime = m_currentProcess.m_finishedTime - m_currentProcess.m_arrivalTime - m_currentProcess.m_originalDuration;
        m_currentProcess.m_responseTime = m_currentProcess.m_startedTime - m_currentProcess.m_arrivalTime;

        m_finishedProcesses.push_back(m_currentProcess);
        emit finishedProcessesChanged();

        m_totalWaitingTime += m_currentProcess.m_waitingTime;
        setAverageWaitingTime(float(m_totalWaitingTime) / m_finishedProcesses.count());

        m_totalResponseTime += m_currentProcess.m_responseTime;
        setAverageResponseTime(float(m_totalResponseTime) / m_finishedProcesses.count());

        m_totalTurnaroundTime += m_currentProcess.m_turnaroundTime;
        setAverageTurnaroundTime(float(m_totalTurnaroundTime) / m_finishedProcesses.count());
    }
    else
    {
        m_currentProcess.m_state = Process::State::ready;
        emit readyQueueSwap();
    }
}

float Schedular::averageResponseTime() const
{
    return m_averageResponseTime;
}

void Schedular::setAverageResponseTime(float averageResponseTime)
{
    if(m_averageResponseTime == averageResponseTime)
        return;

    m_averageResponseTime = averageResponseTime;
    emit averageResponseTimeChanged();
}

float Schedular::averageTurnaroundTime() const
{
    return m_averageTurnaroundTime;
}

void Schedular::setAverageTurnaroundTime(float averageTurnaroundTime)
{
    if(m_averageTurnaroundTime == averageTurnaroundTime)
        return;

    m_averageTurnaroundTime = averageTurnaroundTime;
    emit averageTurnaroundTimeChanged();
}

unsigned int Schedular::idleTime() const
{
    return m_idleTime;
}

void Schedular::setIdleTime(unsigned int idleTime)
{
    if(m_idleTime == idleTime)
        return;

    m_idleTime = idleTime;
    emit idleTimeChanged();
}

float Schedular::averageWaitingTime() const
{
    return m_averageWaitingTime;
}

void Schedular::setAverageWaitingTime(float averageWaitingTime)
{
    qDebug() << "averageWaiting " << averageWaitingTime << " " << m_averageWaitingTime;
    if(m_averageWaitingTime == averageWaitingTime)
        return;

    m_averageWaitingTime = averageWaitingTime;
    emit averageWaitingTimeChanged();
}

bool Schedular::idle() const
{
    return m_idle;
}

void Schedular::setIdle(bool idle)
{
    if(m_idle == idle)
        return;

    m_idle = idle;
    emit idleChanged();
}

QVariant Schedular::readyQueue() const
{
    return QVariant::fromValue(QList<Process>::fromVector(m_readyQueue));
}

Process Schedular::getFinishedProcess(int index) const
{
    return m_finishedProcesses.at(index);
}

Process Schedular::lastFinishedProcess() const
{
   return m_finishedProcesses.last();
}


bool Schedular::isArrivingQueueEmpty() const
{
    return m_isArrivingQueueEmpty;
}

void Schedular::setIsArrivingQueueEmpty(bool isArrivingQueueEmpty)
{
    if(m_isArrivingQueueEmpty == isArrivingQueueEmpty)
        return;

    m_isArrivingQueueEmpty = isArrivingQueueEmpty;
    emit isArrivingQueueEmptyChanged();
}

bool Schedular::running() const
{
    return m_running;
}

void Schedular::setRunning(bool running)
{
    if(m_running == running)
        return;

    m_running = running;
    emit runningChanged();
}

Schedular::AlgorithmId Schedular::algorithmId() const
{
    return m_algorithmId;
}

void Schedular::setAlgorithmId(AlgorithmId algorithmId)
{
    if(m_algorithmId == algorithmId)
        return;

    m_algorithmId = algorithmId;


    switch (m_algorithmId) {
    case SJF:
        m_processComparator =  [](const Process &p1, const Process &p2){
            return p1.m_duration < p2.m_duration;
        };
        break;

    case PRIORITY:
        m_processComparator =  [](const Process &p1, const Process &p2){
            return p1.m_priority < p2.m_priority;
        };
        break;

    default:
        m_processComparator =  [](const Process &p1, const Process &p2){
            return p1.m_arrivalTime < p2.m_arrivalTime;
        };
    }
}

int Schedular::quanta() const
{
    return m_quanta;
}

void Schedular::setQuanta(int quanta)
{
    if(m_quanta == quanta)
        return;

    m_quanta = quanta;
    emit quantaChanged();
}

Process Schedular::currentProcess() const
{
    return m_currentProcess;
}

void Schedular::setCurrentProcess(const Process &currentProcess)
{
    if(m_currentProcess.m_pid == currentProcess.m_pid)
    {
        return;
    }

    m_currentProcess = currentProcess;
    emit currentProcessChanged();
    emit currentProcessDataChanged();
}

unsigned int Schedular::currentTime() const
{
    return m_currentTime;
}

void Schedular::setCurrentTime(unsigned int currentTime)
{
    if(currentTime == m_currentTime)
        return;

    m_currentTime = currentTime;
    emit currentTimeChanged();
}

bool Schedular::paused() const
{
    return m_paused;
}

void Schedular::setPaused(bool paused)
{
    if(paused == m_paused)
        return;

    m_paused = paused;
    emit pausedChanged();
}

int Schedular::delay() const
{
    return m_delay;
}

void Schedular::setDelay(int delay)
{
    if(m_delay == delay)
        return;

    m_delay = delay;

    m_timer.setInterval(m_delay);
    qDebug() << m_delay;

    emit delayChanged();
}

bool Schedular::preemptive() const
{
    return m_preemptive;
}

void Schedular::setPreemptive(bool preemptive)
{
    if(m_preemptive == preemptive)
        return;

    m_preemptive = preemptive;
    emit preemptiveChanged();
}

QVector<Schedular::GantChart> Schedular::gantChart() const
{
    return m_gantChart;
}

QVector<Process> Schedular::finishedProcesses() const
{
    return m_finishedProcesses;
}
