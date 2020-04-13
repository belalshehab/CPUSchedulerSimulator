import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import schedular 0.1


ApplicationWindow {
    id: applicationWindow
    visible: true
    width: 1200
    height: 720


    color: "#333333"

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


    SchedualrAlgorithms {
        id: algorithms
        height: 70
        anchors.top: parent.top
        anchors.topMargin: 30
        anchors.left: parent.left
        anchors.leftMargin: 50
        anchors.right: parent.right
        anchors.rightMargin: 50

        enabled: !schedular.running


        onAlgorithmChanged: {
            switch(algorithms.algorithm)
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

    RowLayout{
        id: rowLayout
        y: 168
        height: 235
        anchors.right: algorithms.right
        anchors.left: algorithms.left
        ProcessesQueue {
            id: arrivalQueue
            x: 61
            y: 145
            width: 470
            height: 235
            Layout.maximumHeight: 385
            Layout.minimumHeight: 235
            Layout.preferredHeight: 235
            Layout.maximumWidth: 890
            Layout.minimumWidth: 500
            Layout.preferredWidth: 600
            Layout.fillWidth: true
            Layout.fillHeight: true

            dim: algorithms.algorithm != 3

            minimumArrivingTime: Schedular.running ? schedular.currentTime +1 : 0
            model: arrivingQueueModel

            enableEdit: !schedular.running
//            dim: !schedular.running
        }


        ReadyQueue {
            id: readyQueue
            x: 565
            y: 175
            width: 235
            height: 235
            Layout.maximumHeight: 385
            Layout.minimumHeight: 235
            Layout.preferredHeight: 235
            Layout.maximumWidth: 385
            Layout.minimumWidth: 235
            Layout.preferredWidth: 235
            Layout.fillWidth: true
            Layout.fillHeight: true
            model: readyQueueModel
        }

        StatusBox {
            id: statusBox
            x: 918
            y: 204
            width: 235
            height: 235
            Layout.maximumHeight: 385
            Layout.minimumHeight: 235
            Layout.preferredHeight: 235
            Layout.maximumWidth: 385
            Layout.minimumWidth: 235
            Layout.preferredWidth: 235
            Layout.fillWidth: true
            Layout.fillHeight: true

            averageTurnaroundTime: Math.round(schedular.averageTurnaroundTime *100) /100
            averageResponseTime: Math.round(schedular.averageResponseTime *100) /100
            averageWaitingTime: Math.round(schedular.averageWaitingTime *100) /100

            idleTime: schedular.idleTime
        }
    }


    ProcessDelegate {
        id: currentProcessDelegate
        x: 314
        y: 461
        width: 250
        height: 48
        visible: !schedular.idle


        pid: schedular.currentProcess.pid
        arrivalTime: schedular.currentProcess.arrivalTime
        duration: schedular.currentProcess.duration
        priority: schedular.currentProcess.priority
    }

    Schedular{
        id: schedular
        delay: controlBox.speed *500
        preemptive: algorithms.preemptive
        quanta: algorithms.quanta

        algorithmId: algorithms.algorithm
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




    ProcessesQueueModel{
        id: arrivingQueueModel
        sortingOn: ProcessesQueueModel.ARRIVAL
    }




    ProcessesQueueModel{
        id: readyQueueModel
        sortingOn: ProcessesQueueModel.ARRIVAL
    }




    Label {
        x: 92
        y: 674
        height: 30
        color: "#bababa"

        text: qsTr("Gant Chartt")
        anchors.verticalCenterOffset: -3
        verticalAlignment: Text.AlignVCenter
        anchors.right: rectangle.left
        anchors.rightMargin: 30
        anchors.verticalCenter: gantChart.verticalCenter
        horizontalAlignment: Text.AlignHCenter
        font.weight: Font.Bold
        font.pixelSize: 20
    }
    GantChart{
        id: gantChart
        anchors.bottom: rectangle.bottom
        anchors.left: rectangle.right
        anchors.leftMargin: 30
        anchors.right: parent.right
        anchors.rightMargin: 30

        model: gantChartModel
    }

    ListModel{
        id: gantChartModel
    }

    Label {
        x: 107
        y: 631

        height: 30
        color: "#bababa"

        text: qsTr("Finished Processes")
        anchors.verticalCenterOffset: -3
        verticalAlignment: Text.AlignVCenter
        anchors.right: rectangle.left
        anchors.rightMargin: 30
        anchors.verticalCenter: finishedProcesses.verticalCenter
        horizontalAlignment: Text.AlignHCenter
        font.weight: Font.Bold
        font.pixelSize: 20
    }
    GantChart {
        id: finishedProcesses

        anchors.bottom: gantChart.top
        anchors.right: gantChart.right
        anchors.left: gantChart.left
        anchors.bottomMargin: 20

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


    ControlBox {
        id: controlBox
        x: 15
        y: 461
        width: 221
        height: 77
        anchors.right: rectangle.left
        anchors.rightMargin: 30

        isRunning: schedular.running
        onStartClicked:
        {
            if(schedular.running)
            {
//                schedular.paus()
            }
            else
            {
                schedular.startSolving()
            }


        }
        onStepClicked: schedular.step()

//        onEndClicked: schedular.end()
    }

    ProcessDetails{
        id: processDetails
        anchors.centerIn: parent
        width: 400
        height: 400
    }

    DeepLine {
        id: deepLine
        x: 267
        y: 607
    }

    Rectangle {
        id: rectangle
        x: 307
        width: 1
        color: "#bfbfbf"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 30
        anchors.top: controlBox.top
        anchors.topMargin: 0
    }

    Label {
        x: 80
        y: 544
        height: 30
        color: "#bababa"
        text: schedular.currentTime
        anchors.right: rectangle.left
        anchors.rightMargin: 30
        font.weight: Font.Bold
        font.pixelSize: 20
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignRight
    }



}

/*##^##
Designer {
    D{i:1;anchors_x:19;anchors_y:93}D{i:5;anchors_width:138;anchors_x:370}D{i:2;anchors_width:138;anchors_x:370}
D{i:6;anchors_x:7}D{i:8;anchors_x:"-98";anchors_y:63}D{i:9;anchors_width:770;anchors_x:19}
D{i:10;anchors_x:7}D{i:11;anchors_width:770;anchors_x:7;anchors_y:494}D{i:19;anchors_height:200;anchors_width:179;anchors_y:449}
}
##^##*/
