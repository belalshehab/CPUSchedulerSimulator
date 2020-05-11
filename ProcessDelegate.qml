import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Item {
    id: root

    height: 30

    property int pid
    property int arrivalTime
    property int duration
    property int priority

    property bool editable: false

    property alias color: colorRec.color

    signal colorClicked
    signal leftClicked
    signal deleteClicked
    width: 600


    RowLayout{
        anchors.fill: parent
        anchors.bottomMargin: 3

        RoundButton{
            id: deleteButton

            Layout.preferredHeight: 30
            Layout.preferredWidth: 30
            Layout.maximumHeight: 35
            Layout.maximumWidth: 35
            Layout.minimumHeight: 25
            Layout.minimumWidth: 25

            text: "X"

            display: AbstractButton.TextOnly
            font.weight: Font.Bold
            font.pixelSize: 10
            font.family: "ROBOTO"

            visible: editable
            enabled: editable


            onClicked:
            {
                deleteClicked()
            }
        }

        Rectangle{
            id: colorRec
            Layout.fillHeight: true
            Layout.bottomMargin: 6
            Layout.topMargin: 6

            Layout.maximumWidth: 7
            Layout.minimumWidth: 5
            Layout.preferredWidth: 6

            color: Qt.rgba(0, 0, 0, 0)
            MouseArea{
                anchors.fill: parent
                enabled: editable
                onClicked: {
                    leftClicked()
                    colorClicked()
                }
            }
        }


        Label {
            text: qsTr("P" + pid)
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
            font.pixelSize: 15
            color: "#fffffff0"
        }
        Rectangle{
            Layout.preferredWidth: 1
            Layout.preferredHeight: -1
            Layout.bottomMargin: 5
            Layout.topMargin: 5
            Layout.fillHeight: true
            Layout.maximumWidth: 1
            Layout.minimumWidth: 1
            color: "#BFBFBF"
            opacity: 0.5
        }

        Label {
            text: qsTr(arrivalTime + "ms")
            Layout.fillHeight: true
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            Layout.fillWidth: true
            font.pixelSize: 15
            color: "#fffffff0"
        }

        Rectangle{
            Layout.preferredWidth: 1
            Layout.preferredHeight: -1
            Layout.bottomMargin: 5
            Layout.topMargin: 5
            Layout.fillHeight: true
            Layout.maximumWidth: 1
            Layout.minimumWidth: 1
            color: "#BFBFBF"
            opacity: 0.5
        }

        Label {
            text: qsTr(duration + "ms")
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "#fffffff0"
        }

        Rectangle{
            Layout.preferredWidth: 1
            Layout.preferredHeight: -1
            Layout.bottomMargin: 5
            Layout.topMargin: 5
            Layout.fillHeight: true
            Layout.maximumWidth: 1
            Layout.minimumWidth: 1
            color: "#BFBFBF"
            opacity: 0.5
        }
        Label {
            text: priority
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            Layout.fillHeight: true
            Layout.fillWidth: true
            color: "#fffffff0"
        }
    }

    DeepLine{
        anchors.bottom: parent.bottom
        width: parent.width
    }
}
