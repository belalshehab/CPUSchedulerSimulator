import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import schedular 0.1


ApplicationWindow {
    id: applicationWindow
    visible: true
    width: 1200
    height: 720


    color: "#000000"

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
        y: 401
        width: 245
        height: 180
        anchors.horizontalCenterOffset: -407
        anchors.horizontalCenter: controlBox.horizontalCenter

        averageTurnaroundTime: Math.round(schedular.averageTurnaroundTime *100) /100
        averageResponseTime: Math.round(schedular.averageResponseTime *100) /100
        averageWaitingTime: Math.round(schedular.averageWaitingTime *100) /100

        idleTime: schedular.idleTime
    }

    ProcessDelegate {
        id: currentProcessDelegate
        y: 601
        height: 48
        anchors.left: parent.left
        anchors.leftMargin: 748
        anchors.right: parent.right
        anchors.rightMargin: 172
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
        isArrivingQueueEmpty: !(arrivingQueueModel.count - currentArivingIndex)

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
                gantChartModel.append({name: "", width: 0,  time: currentTime,   color: "transparent"})
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
        x: 714
        y: 192
        width: 330
        height: 260

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
        x: 288
        y: 135
        height: 260
        model: readyQueueModel
    }

    ProcessesQueueModel{
        id: readyQueueModel
        sortingOn: ProcessesQueueModel.ARRIVAL
    }


    SchedualrAlgorithms {
        id: schedualrAlgorithms
        height: 70
        anchors.top: parent.top
        anchors.topMargin: 30
        anchors.left: parent.left
        anchors.leftMargin: 50
        anchors.right: parent.right
        anchors.rightMargin: 50

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

    Label {
        anchors.left: gantChart.left
        anchors.bottom: gantChart.top
        anchors.bottomMargin: 5
        height: 30

        text: qsTr("Gant Chartt")
        horizontalAlignment: Text.AlignHCenter
        font.weight: Font.Bold
        font.pixelSize: 20
    }
    GantChart{
        id: gantChart
        x: 157
        y: 731
        width: 838
        height: 45
        anchors.right: parent.right
        anchors.rightMargin: 55
        model: gantChartModel
    }

    ListModel{
        id: gantChartModel
    }

    Label {
        anchors.left: finishedProcesses.left
        anchors.bottom: finishedProcesses.top
        anchors.bottomMargin: 5

        height: 30

        text: qsTr("Finished Processes")
        horizontalAlignment: Text.AlignHCenter
        font.weight: Font.Bold
        font.pixelSize: 20
    }
    GantChart {
        id: finishedProcesses
        y: 665
//        height: 20
        anchors.leftMargin: -19
        anchors.right: gantChart.righ
        anchors.left: gantChart.left

        clickable: true
        model: finishedProcessesModel

        onClick: {
            processDetails.open()

            var process = schedular.getFinishedProcess(index)
            processDetails.pid = "Process " + process.pid
            processDetails.arrivalTime = process.arrivalTime
            processDetails.duration = process.originalDuration
            processDetails.priority = process.priority
            processDetails.startedTime = process.startedTime
            processDetails.finishedTime = process.finishedTime
            processDetails.waitingTime = process.waitingTime
            processDetails.responseTime = process.responseTime
            processDetails.turnaroundTime = process.turnaroundTime
        }
    }

    ListModel{
        id: finishedProcessesModel
    }


    GrayRectangle {
        id: controlBox
        x: 756
        y: 389
        width: 245
        height: 180
        anchors.horizontalCenterOffset: 1
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 231
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
                schedular.step()
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
D{i:8;anchors_x:-98;anchors_y:63}D{i:9;anchors_width:770;anchors_x:19}D{i:10;anchors_x:7}
D{i:11;anchors_width:770;anchors_x:7;anchors_y:494}D{i:19;anchors_width:179}
}
##^##*/
