#ifndef PROCESS_H
#define PROCESS_H
#include <iostream>
#include <QObject>
#include <QColor>

struct Process
{
private:
    Q_GADGET
    Q_PROPERTY(unsigned int pid MEMBER m_pid)
    Q_PROPERTY(unsigned int arrivalTime MEMBER m_arrivalTime)
    Q_PROPERTY(unsigned int duration MEMBER m_duration)
    Q_PROPERTY(unsigned int originalDuration MEMBER m_originalDuration)
    Q_PROPERTY(unsigned int priority MEMBER m_priority)
    Q_PROPERTY(unsigned int startedTime MEMBER m_startedTime)
    Q_PROPERTY(unsigned int finishedTime MEMBER m_finishedTime)
    Q_PROPERTY(unsigned int waitingTime MEMBER m_waitingTime)
    Q_PROPERTY(unsigned int responseTime MEMBER m_responseTime)
    Q_PROPERTY(unsigned int turnaroundTime MEMBER m_turnaroundTime)
    Q_PROPERTY(State state MEMBER m_state)
    Q_PROPERTY(QColor color MEMBER m_color)

public:
    Q_ENUMS(State)
    enum State
    {
        waiting = 1, ready, running, finished
    };

    Process(unsigned int m_pid, unsigned int m_arrivalTime, unsigned int m_duration, unsigned int m_priority = 0);
    Process();

    unsigned int m_pid;
    unsigned int m_arrivalTime;
    unsigned int m_duration;
    unsigned int m_originalDuration;
    unsigned int m_priority;

    unsigned int m_startedTime;
    unsigned int m_finishedTime;
    unsigned int m_waitingTime;
    unsigned int m_responseTime;
    unsigned int m_turnaroundTime;

    State m_state;

    QColor m_color;
};

Q_DECLARE_METATYPE(Process)

#endif // PROCESS_H
