#ifndef ARRIVINGQUEUEMODEL_H
#define ARRIVINGQUEUEMODEL_H

#include <QAbstractListModel>
#include <QVariant>

#include "process.h"

class ProcessesQueueModel : public QAbstractListModel
{
    Q_OBJECT

    Q_PROPERTY(SortingOn sortingOn READ sortingOn WRITE setSortingOn NOTIFY sortingOnChanged)
    Q_PROPERTY(bool isEmpty READ isEmpty WRITE setIsEmpty NOTIFY isEmptyChanged)
    Q_PROPERTY(int count READ count WRITE setCount NOTIFY countChanged)

    enum RoleNames {
        PidRole = Qt::UserRole,
        ArrivingTimeRole,
        DurationRole,
        PriorityRole,
        ColorRole
    };

public:
    Q_ENUMS(SortingOn)
    enum SortingOn{
      ARRIVAL = 1, DURATION, PRIORITY
    };
public:
    explicit ProcessesQueueModel(QObject *parent = nullptr);

    Q_INVOKABLE int add(const Process &process);
    Q_INVOKABLE int add(unsigned int arrivalTime, unsigned int duration, unsigned int priority, const QColor &color);
    Q_INVOKABLE void insert(int index, const Process &process);
    Q_INVOKABLE void remove(int index);
    Q_INVOKABLE void clear();
    Q_INVOKABLE Process pop();
    Q_INVOKABLE Process top();
    Q_INVOKABLE Process get(int index);
    Q_INVOKABLE bool isEmpty();
    Q_INVOKABLE void setColor(int index, const QColor &color);
    void setIsEmpty(bool value);

public:
    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;



    SortingOn sortingOn() const;
    void setSortingOn(SortingOn sortingOn);

    int count() const;
    void setCount(int count);

signals:
    void sortingOnChanged();
    void isEmptyChanged();
    void countChanged();

protected:
    virtual QHash<int, QByteArray> roleNames() const override;
private:
    QVector<Process> m_processes;
    QHash <int, QByteArray> m_roleNames;
    SortingOn m_sortingOn;
    unsigned int m_lastPid;
    bool m_isEmpty;
    int m_count;
};

#endif // ARRIVINGQUEUEMODEL_H

