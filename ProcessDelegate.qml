import QtQuick 2.12
import QtQuick.Controls 2.12

Rectangle {
    id: root

    property int pid
    property int arrivalTime
    property int duration
    property int priority

    property bool selected

    height: selected ? 40 : 20

    color: selected ? "#f48fb1" : "transparent"
    Column{
        spacing: 2
        Row{
            spacing: 10
            Label {
                text: qsTr("P" + pid)
                color: "#fffffff0"
                anchors.verticalCenter: parent.verticalCenter
            }
            Label {
                text: qsTr("Arrived: " + arrivalTime + "ms")
                color: "#fffffff0"
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Row{
            spacing: 10
            opacity: selected
            Label {
                text: qsTr("Duration: " + duration + "ms")
                color: "#fffffff0"
                anchors.verticalCenter: parent.verticalCenter
            }

            Label {
                text: qsTr("Pr: " + priority)
                color: "#fffffff0"
                anchors.verticalCenter: parent.verticalCenter
            }
            Behavior on opacity{ NumberAnimation{duration: 150; easing.type: Easing.InOutCubic}}
        }
    }

    Behavior on height{ NumberAnimation {duration: 150; easing.type: Easing.InOutCubic} }

    Behavior on color{ ColorAnimation {duration: 150; easing.type: Easing.InOutCubic}}
}
