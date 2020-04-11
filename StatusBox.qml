import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12


GrayRectangle {
    id: root
    width: 200
    height: 100
    
    property alias currentTime: currentTimeLabel.text
    property alias averageWaitingTime: averageWaitingTimeLabel.text
    property alias idleTime: idleTimeLabel.text

    Label {
        anchors.right: root.left
        anchors.left: root.right
        anchors.bottom: root.top


        height: 30
        text: qsTr("CPU status")
        horizontalAlignment: Text.AlignHCenter
        font.weight: Font.Bold
        font.pixelSize: 20
    }

    ColumnLayout{
        anchors.fill: parent
        anchors.margins: 10
        RowLayout{
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Label {
                id: currentTimeLabel
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
                id: label1
                x: 139
                y: 25
                width: 97
                height: 32
                text: qsTr("Current time")
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
                id: averageWaitingTimeLabel
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
                id: label2
                x: 139
                y: 25
                width: 97
                height: 32
                text: qsTr("Average waiting time")
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
                id: idleTimeLabel
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
                id: label3
                x: 139
                y: 25
                width: 97
                height: 32
                text: qsTr("CPU idle Time")
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillHeight: true
                Layout.fillWidth: true
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }


}
