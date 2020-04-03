import QtQuick 2.12
import QtQuick.Controls 2.12

ApplicationWindow {
    id: applicationWindow
    visible: true
    width: height * 16 /9
    height: 630
    title: "CPU schedular"

    SchedualrAlgorithms {
        id: schedualrAlgorithms
        x: 19
        y: 63
    }

    Label {
        id: label
        y: 0
        height: 27
        text: qsTr("Schedular Algorithms")
        font.weight: Font.Bold
        font.pixelSize: 20
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.bottomMargin: 0
        anchors.right: schedualrAlgorithms.left
        anchors.bottom: schedualrAlgorithms.top
        anchors.left: schedualrAlgorithms.right
        horizontalAlignment: Text.AlignHCenter
    }

    ProcessesQueue {
        id: arrivalQueue
        x: 671
        width: 330
        height: 260
        anchors.top: schedualrAlgorithms.top
        anchors.topMargin: 0

        dim: schedualrAlgorithms.algorithm != 2
    }

    GrayRectangle {
        id: grayRectangle1
        x: 827
        y: 428
        width: 245
        height: 180

        Slider {
            id: speedSlider
            x: 126
            width: 39
            value: 0.5
            stepSize: 0.1
            orientation: Qt.Vertical
            //            width: 20
            anchors.right: parent.right
            anchors.rightMargin: 20
            anchors.top: parent.top
            anchors.topMargin: 0
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 0


            from: 0.1; to: 1

        }

        Button {
            id: button
            x: 83
            y: 28
            width: 62
            height: 49
            text: qsTr("Start")

            onClicked: {
                console.log("Algorithm is: ", schedualrAlgorithms.algorithm)
                console.log("Algorithm is preemptive ? ", schedualrAlgorithms.preemptive)
                console.log("quanta value: ", schedualrAlgorithms.quanta)
            }
        }

        Button {
            id: button2
            x: 83
            y: 123
            width: 62
            height: 49
            text: qsTr("End")
        }
    }

    Label {
        id: label1
        x: 1028
        y: 506
        width: 50
        height: 24
        text: qsTr("Speed")
        rotation: 90
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 20
    }

    GantChart{
        x: 19
        y: 562
    }

    ReadyQueue {
        id: readyQueue
        x: 339
        width: 162
        height: 260
        anchors.top: schedualrAlgorithms.top
        anchors.topMargin: 0
    }

    Label {
        id: label2
        x: 3
        y: 30
        height: 27
        text: qsTr("Ready Queue")
        horizontalAlignment: Text.AlignHCenter
        anchors.bottomMargin: 0
        font.weight: Font.Bold
        font.pixelSize: 20
        anchors.right: readyQueue.left
        anchors.left: readyQueue.right
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.bottom: readyQueue.top
    }

    Label {
        id: label3
        x: -8
        y: 0
        height: 27
        text: qsTr("Arrival Queue")
        horizontalAlignment: Text.AlignHCenter
        anchors.bottomMargin: 0
        font.weight: Font.Bold
        font.pixelSize: 20
        anchors.right: arrivalQueue.left
        anchors.left: arrivalQueue.right
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.bottom: arrivalQueue.top
    }

}

/*##^##
Designer {
    D{i:4;anchors_y:53}D{i:11;anchors_y:63}
}
##^##*/
