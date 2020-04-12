import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import schedular 0.1


ApplicationWindow {
    id: applicationWindow
    visible: true
    width: 1050
    height: 800

    title: "CPU schedular"

    property int currentArivingIndex: 0

    function enqueue(current = false)
    {
        var readyQueueIndex;
        if(current)
        {
            readyQueueIndex = schedular.enqueueArrivedProccess(schedular.currentProcess)
            readyQueueModel.insert(readyQueueIndex, schedular.currentProcess)
            return;
        }

        //        while(!arrivingQueueModel.isEmpty)
        while(currentArivingIndex < arrivingQueueModel.count)
        {
            var p = arrivingQueueModel.get(currentArivingIndex)

            readyQueueIndex = schedular.enqueueArrivedProccess(p)
            if(readyQueueIndex < 0)
            {
                break;
            }

            //            var color = arrivalQueue.ite
            currentArivingIndex++
            readyQueueModel.insert(readyQueueIndex, p)

        }
    }

    StatusBox {
        id: statusBox
        y: 440
        width: 245
        height: 180
        anchors.bottom: controlBox.top
        anchors.bottomMargin: 30
        anchors.horizontalCenterOffset: 0
        anchors.horizontalCenter: controlBox.horizontalCenter

        averageTurnaroundTime: Math.round(schedular.averageTurnaroundTime *100) /100
        averageResponseTime: Math.round(schedular.averageResponseTime *100) /100
        averageWaitingTime: Math.round(schedular.averageWaitingTime *100) /100

        idleTime: schedular.idleTime
    }

    ProcessDelegate {
        id: currentProcessDelegate
        y: 341
        height: 40
        anchors.left: parent.left
        anchors.leftMargin: 370
        anchors.right: parent.right
        anchors.rightMargin: 612
        visible: !schedular.idle

        selected: true

        pid: schedular.currentProcess.pid
        arrivalTime: schedular.currentProcess.arrivalTime
        duration: schedular.currentProcess.duration
        priority: schedular.currentProcess.priority

        //        states: State {
        //                name: "add"
        //                PropertyChanges { target: currentProcessDelegate; y: 50 }
        //            }

        //            transitions: Transition {
        //                PropertyAnimation { properties: "x,y"; easing.type: Easing.InOutQuad }
        //            }
    }

    Schedular{
        id: schedular
        delay: speedSlider.value *500
        preemptive: schedualrAlgorithms.preemptive
        quanta: schedualrAlgorithms.quanta

        algorithmId: schedualrAlgorithms.algorithm
        //        isArrivingQueueEmpty: arrivingQueueModel.isEmpty
        isArrivingQueueEmpty: !(arrivingQueueModel.count - currentArivingIndex)

        onAverageWaitingTimeChanged: console.log("averageWaitingTime ", averageWaitingTime)
        onReadyQueuePoped: {
            readyQueueModel.pop();
        }
        onReadyQueueSwap: {
            enqueue(true);
        }

        onCurrentTimeChanged: {
            enqueue()
            gantChartModel.get(gantChartModel.count -1).width += 20
        }

        onGantChartChanged: {
            if(currentProcess.pid === 0)
            {
                gantChartModel.append({name: "", width: 0,  time: currentTime,   color: "black"})
            }
            else
            {
                gantChartModel.append({name: "P" + schedular.currentProcess.pid, width: 0,  time: currentTime,   color: "orange"})
            }
        }

        onCurrentProcessDataChanged: {
            currentProcessDelegate.duration = currentProcess.duration
        }

        onRunningChanged: {
            if(running)
            {
                currentArivingIndex = 0
                readyQueueModel.clear()
                gantChartModel.clear()
                finishedProcessesModel.clear()

                enqueue()
            }
            else
            {
                gantChartModel.append({name: "" , width: 5,  time: currentTime,   color: "green"})
            }
        }

        onFinishedProcessesChanged: {
            var x = lastFinishedProcess()
            finishedProcessesModel.append({name: "P" + x.pid, width: x.originalDuration *20 ,  time: currentTime,   color: "green"})
        }

    }


    ProcessesQueue {
        id: arrivalQueue
        x: 671
        width: 330
        height: 260
        anchors.top: schedualrAlgorithms.top

        dim: schedualrAlgorithms.algorithm != 3

        minimumArrivingTime: Schedular.running ? schedular.currentTime +1 : 0
        model: arrivingQueueModel

        enabled: !schedular.running
    }

    ProcessesQueueModel{
        id: arrivingQueueModel
        sortingOn: ProcessesQueueModel.ARRIVAL
    }


    ReadyQueue {
        id: readyQueue
        x: 339
        height: 260
        anchors.top: schedualrAlgorithms.top
        model: readyQueueModel
    }

    ProcessesQueueModel{
        id: readyQueueModel
        sortingOn: ProcessesQueueModel.ARRIVAL
    }


    SchedualrAlgorithms {
        id: schedualrAlgorithms
        x: 19
        y: 63
        height: 260

        enabled: !schedular.running


        onAlgorithmChanged: {
            switch(schedualrAlgorithms.algorithm)
            {
            case Schedular.SJF:
                readyQueueModel.sortingOn = ProcessesQueueModel.DURATION
                break;
            case Schedular.PRIORITY:
                readyQueueModel.sortingOn = ProcessesQueueModel.PRIORITY
                break;
            default:
                readyQueueModel.sortingOn = ProcessesQueueModel.ARRIVAL
            }
        }
    }


    GantChart{
        id: gantChart
        y: 562
        height: 45
        anchors.bottom: controlBox.bottom
        anchors.bottomMargin: 10
        anchors.right: controlBox.left
        anchors.rightMargin: 20
        anchors.left: parent.left
        anchors.leftMargin: 20
        model: gantChartModel
    }

    ListModel{
        id: gantChartModel
    }
    GantChart {
        id: finishedProcesses
        anchors.top: controlBox.top
        anchors.topMargin: 20
        anchors.right: gantChart.right
        anchors.rightMargin: 0
        anchors.leftMargin: 0
        anchors.left: gantChart.left

        clickable: true
        model: finishedProcessesModel

        onClick: {
            processDetails.open()
            console.log(pid)

            var x = schedular.getFinishedProcess(pid)
            processDetails.pid = x.pid
            processDetails.finishedTime = x.finishedTime

        }
    }

    ListModel{
        id: finishedProcessesModel
    }


    GrayRectangle {
        id: controlBox
        x: 756
        y: 453
        width: 245
        height: 180
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 30
        anchors.horizontalCenter: arrivalQueue.horizontalCenter

        Slider {
            id: speedSlider
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.rightMargin: 20

            orientation: Qt.Vertical

            width: 40

            value: 1
            stepSize: 0.1
            from: 2; to: 0.1
        }
        Button {
            id: startButton
            x: 107
            y: 73
            width: 62
            height: 49
            text: qsTr("Start")
            anchors.verticalCenter: parent.verticalCenter

            onClicked: {

                schedular.startSolving()
            }
        }

        Button {
            id: endButton
            x: 29
            y: 83
            width: 62
            height: 49
            text: qsTr("End")
            anchors.verticalCenter: parent.verticalCenter
        }

        Label {
            id: label1
            y: 78
            width: 50
            height: 24
            text: qsTr("Speed")
            anchors.verticalCenterOffset: 0
            anchors.left: speedSlider.right
            anchors.leftMargin: -18
            anchors.verticalCenter: parent.verticalCenter
            rotation: 90
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            font.pixelSize: 20
        }

        Button {
            id: stepButton
            x: 107
            y: 63
            width: 62
            height: 49
            text: qsTr("Step")
            anchors.verticalCenterOffset: 58
            anchors.verticalCenter: parent.verticalCenter

            onClicked: {
                console.log("schedular.step() ", schedular.step())
            }
        }

        RowLayout{
            height: 44
            anchors.right: parent.right
            anchors.rightMargin: 65
            anchors.left: parent.left
            anchors.leftMargin: 15
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Label {
                id: turnaroundTimeLabel
                x: 15
                y: 19
                width: 61
                height: 33
                text: schedular.currentTime
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
                text: qsTr("Current Time")
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }

    ProcessDetails{
        id: processDetails
        anchors.centerIn: parent
        width: 400
        height: 400
    }



}

/*##^##
Designer {
    D{i:1;anchors_x:19;anchors_y:93}D{i:2;anchors_width:138;anchors_x:370}D{i:6;anchors_x:7}
D{i:9;anchors_width:770;anchors_x:19}D{i:10;anchors_x:7}D{i:11;anchors_width:770;anchors_x:7;anchors_y:494}
D{i:19;anchors_width:179}
}
##^##*/
