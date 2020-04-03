import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

GrayRectangle {
    id: schedualrAlgorithms
    width: 250
    height: 200


    readonly property alias preemptive: preemptiveCheckBox.checked
    readonly property alias quanta: quantaSelector.value
    property int algorithm

    ColumnLayout {
        id: buttonsColumn
        anchors.right: parent.left
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.rightMargin: -120
        anchors.leftMargin: 0

        AlgorithmButton {
            id: fcfs
            text: qsTr("FCFS")
            checked: true
            onClicked: {
                preemptiveCheckBox.checked = false
                preemptiveCheckBox.enabled = false
                algorithm = 0
            }
        }

        AlgorithmButton {
            id: sjf
            text: qsTr("SJF")
            onClicked: {
                preemptiveCheckBox.enabled = true
                algorithm = 1
            }
        }
        AlgorithmButton {
            id: priority
            text: qsTr("Priority")

            onClicked: {
                preemptiveCheckBox.enabled = true
                algorithm = 2
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
                algorithm = 3
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
