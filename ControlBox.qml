import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import schedular 0.1


//Item {
Rectangle{
    color: "#333333"
    id: root
    property alias speed: speedSlider.value
    property int currentTime: 0
    property bool isRunning: false
    signal startClicked
    signal endClicked
    signal stepClicked

    width: 445
    height: 100
    


    
    ColumnLayout{
        anchors.fill: parent


        RowLayout {
            id: buttonsLayout
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            Button {
                id: stepButton

                text: qsTr("Step")
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                enabled: !isRunning
                onClicked: {
                    stepClicked()
                }
            }
            Button {
                id: startButton

                text: qsTr("S P")
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillWidth: true
                onClicked: {
                    startClicked()
                }
            }

            Button {
                id: endButton

                text: qsTr("E")
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                enabled: isRunning

                onClicked: endClicked()
            }


        }

        Slider {
            id: speedSlider
            Layout.maximumHeight: 35
            Layout.minimumHeight: 25
            Layout.preferredHeight: 30
            Layout.fillHeight: false
            Layout.fillWidth: true

            value: 1
            stepSize: 0.1
            from: 2; to: 0.1
        }
    }

    //    RowLayout{
    //        height: 44
    //        anchors.right: parent.right
    //        anchors.rightMargin: 65
    //        anchors.left: parent.left
    //        anchors.leftMargin: 15
    //        Layout.fillHeight: true
    //        Layout.fillWidth: true
    //        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
    //        Label {
    //            id: turnaroundTimeLabel
    //            x: 15
    //            y: 19
    //            width: 61
    //            height: 33
    //            text: schedular.currentTime
    //            Layout.fillHeight: true
    //            Layout.fillWidth: true
    //            verticalAlignment: Text.AlignVCenter
    //            horizontalAlignment: Text.AlignHCenter
    //        }

    //        Label {
    //            x: 139
    //            y: 25
    //            width: 97
    //            height: 32
    //            text: qsTr("Current Time")
    //            Layout.fillHeight: true
    //            Layout.fillWidth: true
    //            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
    //            verticalAlignment: Text.AlignVCenter
    //            horizontalAlignment: Text.AlignHCenter
    //        }
    //    }
}
