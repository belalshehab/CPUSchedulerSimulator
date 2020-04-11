import QtQuick 2.12
import QtQuick.Controls 2.12
import schedular 0.1


ApplicationWindow {
    id: applicationWindow
    visible: true
    width: height * 16 /9
    height: 630
    title: "CPU schedular"

    function enqueue(current = false)
    {
        var readyQueueIndex;
        if(current)
        {
            readyQueueIndex = schedular.enqueueArrivedProccess(schedular.currentProcess)
            readyQueueModel.insert(readyQueueIndex, schedular.currentProcess)
            return;
        }

        while(!arrivingQueueModel.isEmpty)
        {
            readyQueueIndex = schedular.enqueueArrivedProccess(arrivingQueueModel.top())
            if(readyQueueIndex < 0)
            {
                break;
            }

            //            var color = arrivalQueue.ite
            var p = arrivingQueueModel.pop()
            readyQueueModel.insert(readyQueueIndex, p)

        }
    }

    ProcessDelegate {
        id: currentProcessDelegate
        x: 384
        y: 464
        width: 138
        height: 40
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
        isArrivingQueueEmpty: arrivingQueueModel.isEmpty

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
        x: 19
        y: 562
        width: 770
        height: 45
        model: gantChartModel
    }

    ListModel{
        id: gantChartModel
    }
    GantChart {
        id: finishedProcesses
        y: 413
        width: 770
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
        x: 827
        y: 428
        width: 245
        height: 180

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
                //                if(arrivingQueueModel.top().arrivalTime === 0)
                //                {
                //                    enqueue()
                //                }
                //                else{
                //                    schedular.currentTime = arrivingQueueModel.top().arrivalTime
                //                }

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

        Label {
            id: currentTimeLabel
            x: 30
            y: 131
            width: 61
            height: 33
            text: schedular.currentTime
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
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
    D{i:10;anchors_x:7}
}
##^##*/
