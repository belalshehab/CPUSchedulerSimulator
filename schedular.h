#ifndef SCHEDULAR_H
#define SCHEDULAR_H
#include <queue>
#include <functional>

#include <QVector>
#include <QObject>
#include <QTimer>
#include <QVariantList>

#include "process.h"

class Schedular: public QObject
{
    Q_OBJECT

    Q_PROPERTY(bool preemptive READ preemptive WRITE setPreemptive NOTIFY preemptiveChanged)
    Q_PROPERTY(int delay READ delay WRITE setDelay NOTIFY delayChanged)
    Q_PROPERTY(unsigned int currentTime READ currentTime WRITE setCurrentTime NOTIFY currentTimeChanged)
    Q_PROPERTY(bool paused READ paused WRITE setPaused NOTIFY pausedChanged)
    Q_PROPERTY(Process currentProcess READ currentProcess NOTIFY currentProcessChanged)
    Q_PROPERTY(int quanta READ quanta WRITE setQuanta NOTIFY quantaChanged)
    Q_PROPERTY(AlgorithmId algorithmId READ algorithmId WRITE setAlgorithmId NOTIFY algorithmIdChanged)
    Q_PROPERTY(bool running READ running WRITE setRunning NOTIFY runningChanged)
    Q_PROPERTY(bool idle READ idle WRITE setIdle NOTIFY idleChanged)
    Q_PROPERTY(bool isArrivingQueueEmpty READ isArrivingQueueEmpty WRITE setIsArrivingQueueEmpty NOTIFY isArrivingQueueEmptyChanged)

    Q_PROPERTY(float averageWaitingTime READ averageWaitingTime WRITE setAverageWaitingTime NOTIFY averageWaitingTimeChanged)
    Q_PROPERTY(float averageTurnaroundTime READ averageTurnaroundTime WRITE setAverageTurnaroundTime NOTIFY averageTurnaroundTimeChanged)
    Q_PROPERTY(float averageResponseTime READ averageResponseTime WRITE setAverageResponseTime NOTIFY averageResponseTimeChanged)
    Q_PROPERTY(unsigned int idleTime READ idleTime WRITE setIdleTime NOTIFY idleTimeChanged)

private:
    struct GantChart{
        unsigned int id, time;
    };

public:
    Q_ENUMS(AlgorithmId)
    enum AlgorithmId{
      FCFS = 1, SJF = 2, PRIORITY = 3, RR = 4
    };
public:
    explicit Schedular(QObject *parent = nullptr);

    void solve();

    Q_INVOKABLE void startSolving();
    Q_INVOKABLE bool step();
    Q_INVOKABLE int enqueueArrivedProccess(const Process &process);
    Q_INVOKABLE void reset();

    Q_INVOKABLE void pause();
    Q_INVOKABLE void stop();


    QVector<Process> finishedProcesses() const;
    QVector<GantChart> gantChart() const;

    bool preemptive() const;
    void setPreemptive(bool preemptive);

    int delay() const;
    void setDelay(int delay);

    bool paused() const;
    void setPaused(bool paused);

    unsigned int currentTime() const;
    void setCurrentTime(unsigned int currentTime);


    Process currentProcess() const;
    void setCurrentProcess(const Process &currentProcess);

    int quanta() const;
    void setQuanta(int quanta);

    AlgorithmId algorithmId() const;
    void setAlgorithmId(AlgorithmId algorithmId);

    bool running() const;
    void setRunning(bool running);

    bool isArrivingQueueEmpty() const;
    void setIsArrivingQueueEmpty(bool isArrivingQueueEmpty);

    Q_INVOKABLE QVariant readyQueue() const;

    Q_INVOKABLE Process getFinishedProcess(int index) const;
    Q_INVOKABLE Process lastFinishedProcess() const;

    bool idle() const;
    void setIdle(bool idle);

    float averageWaitingTime() const;
    void setAverageWaitingTime(float averageWaitingTime);

    float averageTurnaroundTime() const;
    void setAverageTurnaroundTime(float averageTurnaroundTime);

    float averageResponseTime() const;
    void setAverageResponseTime(float averageResponseTime);

    unsigned int idleTime() const;
    void setIdleTime(unsigned int idleTime);

signals:
    void preemptiveChanged();
    void delayChanged();
    void currentTimeChanged();
    void pausedChanged();
    void currentProcessChanged();
    void currentProcessDataChanged();
    void quantaChanged();
    void algorithmIdChanged();
    void runningChanged();
    void idleChanged();
    void isArrivingQueueEmptyChanged();
    void gantChartChanged();
    void finishedProcessesChanged();

    void readyQueuePoped();
    void readyQueueSwap();

    void averageWaitingTimeChanged();
    void averageTurnaroundTimeChanged();
    void averageResponseTimeChanged();

    void idleTimeChanged();


private:

    void runReadyProcess();
    void stopCurrentProcess();

private:
    std::function<bool(Process, Process)> m_processComparator;
    std::function<bool(Process, Process)> m_processComparatorOrEqual;

    QVector<Process> m_readyQueue;

    AlgorithmId m_algorithmId;
    bool m_preemptive;
    int m_quanta;
    int m_currentQuanta;

    unsigned int m_currentTime;
    Process m_currentProcess;

    bool m_running;
    bool m_paused;
    bool m_idle;

    int m_delay;
    bool m_isArrivingQueueEmpty;

    QVector<Process> m_finishedProcesses;
    QVector<GantChart> m_gantChart;

    unsigned int m_totalWaitingTime;
    float m_averageWaitingTime;

    unsigned int m_totalTurnaroundTime;
    float m_averageTurnaroundTime;

    unsigned int m_totalResponseTime;
    float m_averageResponseTime;

    unsigned int m_idleTime;

    QTimer m_timer;
};

#endif // SCHEDULAR_H
