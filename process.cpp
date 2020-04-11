#include "process.h"
#include <sstream>
#include <string>
Process::Process(unsigned int id, unsigned int arrivalTime, unsigned int duration, unsigned int priority):
    m_pid(id), m_arrivalTime(arrivalTime), m_duration(duration), m_originalDuration(duration), m_priority(priority), m_state(State::waiting)
{}

Process::Process()
{

}

//std::string Process::dump() const
//{
//    std::stringstream stringStream;

//    std::string stateString;

//    switch (m_state)
//    {
//    case State::waiting:
//        stateString = "waiting";
//        break;
//    case State::ready:
//        stateString = "ready";
//        break;
//    case State::running:
//        stateString = "running";
//        break;
//    case State::finished:
//        stateString = "finished";
//        break;
//    }
//    stringStream  << "P" << m_pid << ": arrivalTime: " << m_arrivalTime << ", originalDuration: " << m_originalDuration << ", priority: " << m_priority <<
//                     ", startedTime: " << m_startedTime << ", finishedTime: " << m_finishedTime << ", waitingTime: " << m_waitingTime <<
//                     ", responseTime: " << m_responseTime << ", turnaroundTime: " << m_turnaroundTime << ", state: " << stateString;
//    return stringStream.str();
//}

//bool Process::operator<(const Process &rhs) const
//{
//    return m_arrivalTime < rhs.m_arrivalTime;
//}

//bool Process::operator>(const Process &rhs) const
//{
//    return m_arrivalTime > rhs.m_arrivalTime;
//}
