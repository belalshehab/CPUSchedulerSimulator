import QtQuick 2.12
import QtQuick.Controls 2.12
import schedular 0.1
Popup {
    id: root

    background: Rectangle{
        color: "black"
    }

    property int pid
    property int arrivalTime
    property int duration
    property int priority
    property int startedTime
    property int finishedTime
    property int waitingTime
    property int m_responseTime;
    property int m_turnaroundTime;

    modal: true
    dim: true
    Label {
        id: pidLabel
        x: 240
        y: 56
        width: 139
        height: 49
        text: pid
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
    }

    Label {
        id: finishedLabel
        x: 104
        y: 180
        width: 141
        height: 26
        text: finishedTime
    }

}
