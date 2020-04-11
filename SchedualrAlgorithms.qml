import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import schedular 0.1

GrayRectangle {
    id: schedualrAlgorithms
    width: 250
    height: 200


    readonly property alias preemptive: preemptiveCheckBox.checked
    readonly property alias quanta: quantaSelector.value
    property int algorithm : Schedular.FCFS

    Label {
        id: label

        anchors.right: schedualrAlgorithms.left
        anchors.bottom: schedualrAlgorithms.top
        anchors.left: schedualrAlgorithms.right

        height: 27

        text: qsTr("Schedular Algorithms")
        font.weight: Font.Bold
        font.pixelSize: 20
        horizontalAlignment: Text.AlignHCenter
    }

    ColumnLayout {
        id: buttonsColumn
        anchors.right: parent.left
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.rightMargin: -120

        AlgorithmButton {
            id: fcfs
            text: qsTr("FCFS")
            checked: true
            onClicked: {
                preemptiveCheckBox.checked = false
                preemptiveCheckBox.enabled = false
                algorithm = Schedular.FCFS
            }
        }

        AlgorithmButton {
            id: sjf
            text: qsTr("SJF")
            onClicked: {
                preemptiveCheckBox.enabled = true
                algorithm = Schedular.SJF
            }
        }
        AlgorithmButton {
            id: priority
            text: qsTr("Priority")

            onClicked: {
                preemptiveCheckBox.enabled = true
                algorithm = Schedular.PRIORITY
            }
        }
        AlgorithmButton {
            id: roundRobin
            text: qsTr("RR")
            checkable: true
            checked: false
            onClicked: {
                preemptiveCheckBox.checked = true
                preemptiveCheckBox.enabled = false
                algorithm = Schedular.RR
            }
        }
    }


    CheckBox {
        id: preemptiveCheckBox
        x: 135
        y: 20
        text: qsTr("Preemptive")
        contentItem: Text {
            text: parent.text
            horizontalAlignment: Text.AlignLeft
            color: "#fffffff0"
            leftPadding: parent.indicator.width + parent.spacing
            verticalAlignment: Text.AlignVCenter
        }
        enabled: false
    }


    QuantaSelctor {
        id: quantaSelector
        y: 143

        height: 47
        anchors.left: buttonsColumn.right
        anchors.leftMargin: 15
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 10
        anchors.right: parent.right
        anchors.rightMargin: 10
        opacity: roundRobin.checked
    }

}
