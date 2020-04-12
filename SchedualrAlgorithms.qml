import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import schedular 0.1

GrayRectangle {
    id: schedualrAlgorithms
    width: 1160
    height: 75


    readonly property alias preemptive: preemptiveCheckBox.checked
    readonly property alias quanta: quantaSelector.value
    property int algorithm : Schedular.FCFS

    RowLayout {
        id: buttonsColumn
        anchors.rightMargin: 30
        anchors.leftMargin: 30
        spacing: 10
        anchors.fill: parent

        Label {
            id: label

            height: 27
            color: "#bababa"

            text: qsTr("Algorithms:")
            Layout.fillHeight: true
            Layout.fillWidth: false
            verticalAlignment: Text.AlignVCenter
            font.capitalization: Font.MixedCase
            font.weight: Font.Bold
            font.pixelSize: 30
            horizontalAlignment: Text.AlignHCenter
        }

        AlgorithmButton {
            id: fcfs
            text: qsTr("FCFS")
            Layout.fillHeight: true
            Layout.fillWidth: false
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
            Layout.fillHeight: true
            Layout.fillWidth: false
            onClicked: {
                preemptiveCheckBox.enabled = true
                algorithm = Schedular.SJF
            }
        }
        AlgorithmButton {
            id: priority
            text: qsTr("PR")
            Layout.fillHeight: true
            Layout.fillWidth: false

            onClicked: {
                preemptiveCheckBox.enabled = true
                algorithm = Schedular.PRIORITY
            }
        }
        AlgorithmButton {
            id: roundRobin
            text: qsTr("RR")
            Layout.fillHeight: true
            Layout.fillWidth: false
            checkable: true
            checked: false
            onClicked: {
                preemptiveCheckBox.checked = true
                preemptiveCheckBox.enabled = false
                algorithm = Schedular.RR
            }
        }

        QuantaSelctor {
            id: quantaSelector
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.preferredHeight: 70
            Layout.preferredWidth: 200
            Layout.fillHeight: false
            Layout.fillWidth: false

            enabled: roundRobin.checked
        }

        CheckBox {
            id: preemptiveCheckBox
            text: qsTr("Preemptive")
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            Layout.fillHeight: true
            Layout.fillWidth: false

            contentItem: Text {
                text: parent.text
                font.weight: Font.Bold
                font.pixelSize: 25
                font.family: "Roboto"
                color: "#bababa"
                horizontalAlignment: Text.AlignLeft
                leftPadding: parent.indicator.width + parent.spacing
                verticalAlignment: Text.AlignVCenter
            }
            enabled: false
        }


    }



}

/*##^##
Designer {
    D{i:1;anchors_width:853}
}
##^##*/
