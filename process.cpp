#include "process.h"
#include <sstream>
#include <string>

Process::Process(unsigned int id, unsigned int arrivalTime, unsigned int duration, unsigned int priority):
    id(id), arrivalTime(arrivalTime), duration(duration), originalDuration(duration), priority(priority), state(State::waiting)
{}

std::string Process::dump() const
{
    std::stringstream stringStream;

    std::string stateString;

    switch (state)
    {
    case State::waiting:
        stateString = "waiting";
        break;
    case State::ready:
        stateString = "ready";
        break;
    case State::running:
        stateString = "running";
        break;
    case State::finished:
        stateString = "finished";
        break;
    }
    stringStream  << "P" << id << ": arrivalTime: " << arrivalTime << ", originalDuration: " << originalDuration << ", priority: " << priority <<
                     ", startedTime: " << startedTime << ", finishedTime: " << finishedTime << ", waitingTime: " << waitingTime <<
                     ", responseTime: " << responseTime << ", turnaroundTime: " << turnaroundTime << ", state: " << stateString;
    return stringStream.str();
}

bool Process::operator<(const Process &rhs) const
{
    return arrivalTime < rhs.arrivalTime;
}

bool Process::operator>(const Process &rhs) const
{
    return arrivalTime > rhs.arrivalTime;
}
