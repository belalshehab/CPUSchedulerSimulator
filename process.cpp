#include "process.h"
#include <sstream>
#include <string>
Process::Process(unsigned int id, unsigned int arrivalTime, unsigned int duration, unsigned int priority):
    m_pid(id), m_arrivalTime(arrivalTime), m_duration(duration), m_originalDuration(duration), m_priority(priority), m_state(State::waiting)
{}

Process::Process(): m_pid(0), m_duration(0), m_originalDuration(0)
{
}
