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
    Q_PROPERTY(bool m_paused READ paused WRITE setPaused NOTIFY pausedChanged)
    Q_PROPERTY(Process currentProcess READ currentProcess NOTIFY currentProcessChanged)
    Q_PROPERTY(int quanta READ quanta WRITE setQuanta NOTIFY quantaChanged)
    Q_PROPERTY(AlgorithmId algorithmId READ algorithmId WRITE setAlgorithmId NOTIFY algorithmIdChanged)
    Q_PROPERTY(bool running READ running WRITE setRunning NOTIFY runningChanged)
    Q_PROPERTY(bool idle READ idle WRITE setIdle NOTIFY idleChanged)
    Q_PROPERTY(bool isArrivingQueueEmpty READ isArrivingQueueEmpty WRITE setIsArrivingQueueEmpty NOTIFY isArrivingQueueEmptyChanged)
    Q_PROPERTY(QVariant readyQueue READ readyQueue NOTIFY readyQueueChanged)
//    Q_PROPERTY(int readyQueueSize READ readyQueueSize WRITE setReadyQueueSize NOTIFY readyQueueSizeChanged)



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
    //    void insertProcess(const Process &process);
    Q_INVOKABLE void startSolving();
    void solve();
    Q_INVOKABLE bool step();
    Q_INVOKABLE int enqueueArrivedProccess(const Process &process);
    Q_INVOKABLE void reset();


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
//    Q_INVOKABLE GantChart lastGantChanr() const;
//    void setReadyQueue(const QVariant &readyQueue);

    bool idle() const;
    void setIdle(bool idle);

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
    void readyQueueChanged();
    void gantChartChanged();
    void finishedProcessesChanged();

    void readyQueuePoped();
    void readyQueueSwap();

private:

    void runReadyProcess();
    void stopCurrentProcess();

private:
    std::function<bool(Process, Process)> m_processComparator;
    QVector<Process> m_readyQueue;

    AlgorithmId m_algorithmId;
    bool m_preemptive;
    int m_quanta;

    unsigned int m_currentTime;
    Process m_currentProcess;

    bool m_running;
    bool m_paused;
    bool m_idle;

    int m_delay;
    bool m_isArrivingQueueEmpty;

    QVector<Process> m_finishedProcesses;
    QVector<GantChart> m_gantChart;

    QTimer m_timer;
};

#endif // SCHEDULAR_H
