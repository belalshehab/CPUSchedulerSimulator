import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12


Popup {
    id: root

    background: GrayRectangle{

    }

    property alias pid: pidLabel.text
    property alias arrivalTime: arrivalTimeLabel.text
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

        Item{
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            RowLayout{
                anchors.fill: parent


                Label {
                    id: label1
                    text: qsTr("Arrival Time")
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }

                Label {
                    id: arrivalTimeLabel
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
                    text: qsTr("Duration")
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }

                Label {
                    id: durationLabel
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
                    text: qsTr("Priority")
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }

                Label {
                    id: priorityLabel
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
                    text: qsTr("Started Time")
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }

                Label {
                    id: startedTimeLabel
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
                    text: qsTr("Finished Time")
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }

                Label {
                    id: finishedTimeLabel
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
                    text: qsTr("Turnaround Time")
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
                    text: qsTr("Waiting Time")
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }

                Label {
                    id: waitingTimeLabel
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
                    text: qsTr("Response Time")
                    Layout.fillHeight: true
                    Layout.fillWidth: true
                    verticalAlignment: Text.AlignVCenter
                    horizontalAlignment: Text.AlignLeft
                }

                Label {
                    id: responseTimeLabel
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
    }
}

/*##^##
Designer {
    D{i:0;autoSize:true;height:480;width:640}
}
##^##*/
