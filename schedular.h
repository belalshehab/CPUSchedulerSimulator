#ifndef SCHEDULAR_H
#define SCHEDULAR_H
#include <queue>
#include <functional>

#include "process.h"

class Schedular
{
private:
    struct GantChart{
        unsigned int id, time;
    };
public:
    Schedular(std::function<bool(Process, Process)> processComparator, bool preemptive = false);
    void insertProcess(const Process &process);
    void solve();
    bool step();
    std::vector<Process> finishedProcesses() const;
    std::vector<GantChart> gantChart() const;

private:
    void _enqueueArrivedProccess();
    void _runReadyProcess();
    void _stopCurrentProcess();

private:
    std::function<bool(Process, Process)> _processComparator;

    std::priority_queue<Process, std::vector<Process>, decltype (_processComparator)> _readyQueue{_processComparator};
    std::priority_queue<Process, std::vector<Process>, std::greater<Process> > _arrivingQueue;

    std::vector<Process> _finishedProcesses;
    std::vector<GantChart> _gantChart;

    bool _preemptive;

    unsigned int _currentTime;
    Process _currentProcess;
};

#endif // SCHEDULAR_H
