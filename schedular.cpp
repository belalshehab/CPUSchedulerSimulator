#include "schedular.h"
#include <algorithm>

Schedular::Schedular(std::function<bool(Process, Process)> processComparator, bool preemptive) :
    _processComparator{processComparator},
    _preemptive(preemptive),
    _currentTime(0), _currentProcess{0, 0, 0}
{

}

void Schedular::_enqueueArrivedProccess()
{
    while (!_arrivingQueue.empty())
    {
        if(_arrivingQueue.top().arrivalTime == _currentTime)
        {
            _readyQueue.push(_arrivingQueue.top());
            _arrivingQueue.pop();
        }
        else
            break;
    }
}


void Schedular::insertProcess(const Process &process)
{
    _arrivingQueue.push(process);
}

void Schedular::solve()
{
    _currentTime = _arrivingQueue.top().arrivalTime;
    _enqueueArrivedProccess();

    _runReadyProcess();

    while(step())
    {
    }
}

bool Schedular::step()
{
    if(_currentProcess.duration || (!_readyQueue.empty() && !_arrivingQueue.empty()))
    {
        ++_currentTime;
        --_currentProcess.duration;

        _enqueueArrivedProccess();

        if(_currentProcess.duration == 0 || (_preemptive && (_readyQueue.empty() ? false : _processComparator(_currentProcess, _readyQueue.top()))))
        {
            _stopCurrentProcess();
            _runReadyProcess();
        }
        return true;
    }
    else
        return false;
}


void Schedular::_runReadyProcess()
{
    if(_readyQueue.empty())
        return;
    _currentProcess = _readyQueue.top();
    _readyQueue.pop();
    if(_currentProcess.state == Process::State::waiting)
        _currentProcess.startedTime  = _currentTime;

    _currentProcess.state = Process::State::running;

    _gantChart.push_back({_currentProcess.id, _currentTime});
}

void Schedular::_stopCurrentProcess()
{
    if(_currentProcess.duration == 0)
    {
        _currentProcess.finishedTime = _currentTime;
        _currentProcess.state = Process::State::finished;
        _currentProcess.turnaroundTime = _currentProcess.finishedTime - _currentProcess.arrivalTime;
        _currentProcess.waitingTime = _currentProcess.finishedTime - _currentProcess.arrivalTime - _currentProcess.originalDuration;
        _currentProcess.responseTime = _currentProcess.startedTime - _currentProcess.arrivalTime;
        _finishedProcesses.push_back(_currentProcess);
    }
    else
    {
        _currentProcess.state = Process::State::ready;
        _readyQueue.push(_currentProcess);
    }
}

std::vector<Schedular::GantChart> Schedular::gantChart() const
{
    return _gantChart;
}

std::vector<Process> Schedular::finishedProcesses() const
{
    return _finishedProcesses;
}


