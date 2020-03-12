#ifndef PROCESS_H
#define PROCESS_H
#include <iostream>

struct Process
{
    enum class State
    {
        waiting = 1, ready, running, finished
    };

    Process(unsigned int id, unsigned int arrivalTime, unsigned int duration, unsigned int priority = 0);

    unsigned int id;
    unsigned int arrivalTime;
    unsigned int duration;
    unsigned int originalDuration;
    unsigned int priority;

    unsigned int startedTime;
    unsigned int finishedTime;
    unsigned int waitingTime;
    unsigned int responseTime;
    unsigned int turnaroundTime;

    State state;

    std::string dump() const;
    bool operator<(const Process &rhs) const;
    bool operator>(const Process &rhs) const;
};

#endif // PROCESS_H
