import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12


GrayRectangle {
    id: root
    implicitWidth: 235
    implicitHeight: 235

    
    property alias averageTurnaroundTime: turnaroundTimeLabel.text
    property alias averageWaitingTime: averageWaitingTimeLabel.text
    property alias averageResponseTime: responseTimeLabel.text
    property alias idleTime: idleTimeLabel.text

    Label {
        id: label
        anchors.right: root.left
        anchors.left: root.right
        anchors.top: root.top


        height: 30
        text: qsTr("CPU status")
        anchors.topMargin: 5
        horizontalAlignment: Text.AlignHCenter
        font.weight: Font.Bold
        font.pixelSize: 20
    }

    ColumnLayout{
        anchors.top: label.bottom
        anchors.topMargin: 5
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.margins: 15

        Item{
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            RowLayout{
                anchors.fill: parent

                Label {
                    id: label1
                    text: qsTr("Average Turnaround Time")
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }

                Label {
                    id: turnaroundTimeLabel
                    text: qsTr("10")
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: false
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                }

            }
            DeepLine{
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
            }
        }


        Item{
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            RowLayout{
                anchors.fill: parent
                Label {
                    id: label2
                    text: qsTr("Average Waiting Time")
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }

                Label {
                    id: averageWaitingTimeLabel
                    text: qsTr("5.25")
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: false
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                }

            }
            DeepLine{
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
            }
        }

        Item{
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            RowLayout{
                anchors.fill: parent
                Label {
                    id: label3
                    text: qsTr("Average Response Time")
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }

                Label {
                    id: responseTimeLabel

                    text: qsTr("2")
                    Layout.fillWidth: false
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.fillHeight: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                }

            }
            DeepLine{
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
            }
        }

        Item{
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            RowLayout{
                anchors.fill: parent
                Label {
                    id: label4
                    text: qsTr("CPU Idle Time")
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }

                Label {
                    id: idleTimeLabel

                    text: qsTr("0")
                    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                    Layout.fillHeight: true
                    Layout.fillWidth: false
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignRight
                }

            }
            DeepLine{
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
            }
        }
    }

}
