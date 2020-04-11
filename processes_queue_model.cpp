#include "processes_queue_model.h"

#include <QDebug>


ProcessesQueueModel::ProcessesQueueModel(QObject *parent)
    : QAbstractListModel(parent), m_sortingOn(SortingOn::ARRIVAL), m_lastPid(0), m_isEmpty{true}
{
    m_roleNames[PidRole] = "pid";
    m_roleNames[ArrivingTimeRole] = "arrivalTime";
    m_roleNames[DurationRole] = "duration";
    m_roleNames[PriorityRole] = "priority";
}

int ProcessesQueueModel::add(const Process &process)
{
    std::vector<Process>::reverse_iterator itr;

    long long index = 0;

     if(m_sortingOn == ARRIVAL) //FCFS
     {
         index = m_processes.rend() -  std::find_if(m_processes.rbegin(), m_processes.rend(), [=](const Process &p){
             return p.m_arrivalTime <= process.m_arrivalTime;
         });
     }
     else if(m_sortingOn == DURATION) //SJF
     {
         index = m_processes.rend() -  std::find_if(m_processes.rbegin(), m_processes.rend(), [=](const Process &p){
             return p.m_duration <= process.m_duration;
         });
     }

     else if(m_sortingOn == PRIORITY) //Priority
     {
         index = m_processes.rend() -  std::find_if(m_processes.rbegin(), m_processes.rend(), [=](const Process &p){
             return p.m_priority <= process.m_priority;
         });
     }

     int location = static_cast<int>(index);

     insert(location, process);

     return location;
}

int ProcessesQueueModel::add(unsigned int arrivalTime, unsigned int duration, unsigned int priority)
{
   Process process(++m_lastPid, arrivalTime, duration, priority);
   return add(process);
}

void ProcessesQueueModel::insert(int index, const Process &process)
{
    if(index < 0 || index > m_processes.count())
        return;

    emit beginInsertRows(QModelIndex(), index, index);
    m_processes.insert(index, process);
    emit endInsertRows();

    setCount(m_processes.count());
    setIsEmpty(false);
}

void ProcessesQueueModel::remove(int index)
{
    if(index < 0 || index >= m_processes.count())
        return;

    if(m_processes.count() == 1)
    {
        m_lastPid = 0;
    }

    else if(m_processes[index].m_pid == m_lastPid)
    {
        --m_lastPid;
    }

    emit beginRemoveRows(QModelIndex(), index, index);
    m_processes.removeAt(index);
    emit endRemoveRows();

    setCount(m_processes.count());
    setIsEmpty(m_processes.isEmpty());
}

void ProcessesQueueModel::clear()
{
    m_lastPid = 0;

    emit beginResetModel();
    m_processes.clear();
    emit endResetModel();

    setCount(0);
    setIsEmpty(true);
}

Process ProcessesQueueModel::pop()
{
    Process process = top();
    remove(0);
    return process;
}

Process ProcessesQueueModel::top()
{
    return m_processes.first();
}


Process ProcessesQueueModel::get(int index)
{
    if(index < 0 || index >= m_processes.count())
        return Process();

    return m_processes[index];
}

bool ProcessesQueueModel::isEmpty()
{
    return m_processes.isEmpty();
}

void ProcessesQueueModel::setIsEmpty(bool value)
{
    if(value == m_isEmpty)
        return;

    m_isEmpty = value;
    emit isEmptyChanged();
}

int ProcessesQueueModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return m_processes.count();
}

QVariant ProcessesQueueModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    switch (role) {
    case PidRole:
        return m_processes[index.row()].m_pid;
    case ArrivingTimeRole:
        return m_processes[index.row()].m_arrivalTime;
    case DurationRole:
        return m_processes[index.row()].m_duration;
    case PriorityRole:
        return m_processes[index.row()].m_priority;
    }

    return QVariant();
}

QHash<int, QByteArray> ProcessesQueueModel::roleNames() const
{
    return m_roleNames;
}

int ProcessesQueueModel::count() const
{
    return m_count;
}

void ProcessesQueueModel::setCount(int count)
{
    if(m_count == count)
        return;

    m_count = count;
    emit countChanged();
}

ProcessesQueueModel::SortingOn ProcessesQueueModel::sortingOn() const
{
    return m_sortingOn;
}

void ProcessesQueueModel::setSortingOn(SortingOn sortingOn)
{
    if(m_sortingOn == sortingOn)
        return;

    m_sortingOn = sortingOn;
    emit sortingOnChanged();
}
