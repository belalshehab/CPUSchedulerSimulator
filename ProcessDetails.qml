import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12


Popup {
    id: root

    background: Rectangle{
        color: "black"
    }

    property alias pid: pidLabel.text
    property alias arrivalTime: arriavlaTimeLabel.text
    property alias duration: durationLabel.text
    property alias priority: priorityLabel.text
    property alias startedTime: startedTimeLabel.text
    property alias finishedTime: finishedTimeLabel.text
    property alias waitingTime: waitingTimeLabel.text
    property alias responseTime: responseTimeLabel.text
    property alias turnaroundTime: turnaroundTimeLabel.text

    modal: true
    dim: true

    Label {
        id: pidLabel
        x: 139
        width: 97
        height: 32
        text: qsTr("Process 1")
        anchors.top: parent.top
        anchors.topMargin: 25
        anchors.horizontalCenter: parent.horizontalCenter
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter

    }

    ColumnLayout{
        anchors.topMargin: 15
        anchors.top: pidLabel.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left

        anchors.margins: 15

        RowLayout{
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Label {
                id: arriavlaTimeLabel
                x: 20
                y: 90
                width: 61
                height: 33
                text: qsTr("0")
                Layout.fillHeight: true
                Layout.fillWidth: true
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            Label {
                x: 139
                y: 25
                width: 97
                height: 32
                text: qsTr("Arriavla Time")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillHeight: true
                Layout.fillWidth: true
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }

        RowLayout{
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Label {
                id: durationLabel
                x: 20
                y: 90
                width: 61
                height: 33
                text: qsTr("0")
                Layout.fillHeight: true
                Layout.fillWidth: true
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            Label {
                x: 139
                y: 25
                width: 97
                height: 32
                text: qsTr("Duration")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillHeight: true
                Layout.fillWidth: true
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }

        RowLayout{
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Label {
                id: priorityLabel
                x: 15
                y: 19
                width: 61
                height: 33
                text: qsTr("0")
                Layout.fillHeight: true
                Layout.fillWidth: true
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            Label {
                x: 139
                y: 25
                width: 97
                height: 32
                text: qsTr("Priority")
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }

        RowLayout{
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Label {
                id: startedTimeLabel
                x: 15
                y: 19
                width: 61
                height: 33
                text: qsTr("0")
                Layout.fillHeight: true
                Layout.fillWidth: true
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            Label {
                x: 139
                y: 25
                width: 97
                height: 32
                text: qsTr("Started Time")
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }

        RowLayout{
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Label {
                id: finishedTimeLabel
                x: 15
                y: 19
                width: 61
                height: 33
                text: qsTr("0")
                Layout.fillHeight: true
                Layout.fillWidth: true
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            Label {
                x: 139
                y: 25
                width: 97
                height: 32
                text: qsTr("Finished Time")
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }

        RowLayout{
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Label {
                id: turnaroundTimeLabel
                x: 15
                y: 19
                width: 61
                height: 33
                text: qsTr("0")
                Layout.fillHeight: true
                Layout.fillWidth: true
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            Label {
                x: 139
                y: 25
                width: 97
                height: 32
                text: qsTr("Turnaround Time")
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }

        RowLayout{
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Label {
                id: waitingTimeLabel
                x: 20
                y: 51
                width: 61
                height: 33
                text: qsTr("0")
                Layout.fillHeight: true
                Layout.fillWidth: true
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            Label {
                x: 139
                y: 25
                width: 97
                height: 32
                text: qsTr("Waiting Time")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillHeight: true
                Layout.fillWidth: true
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }

        RowLayout{
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Label {
                id: responseTimeLabel
                x: 20
                y: 90
                width: 61
                height: 33
                text: qsTr("0")
                Layout.fillHeight: true
                Layout.fillWidth: true
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }

            Label {
                x: 139
                y: 25
                width: 97
                height: 32
                text: qsTr("Response Time")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillHeight: true
                Layout.fillWidth: true
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }

    }
}
