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


    ColumnLayout {
        id: appLayout
        spacing: 30
        anchors.fill: parent
        anchors.margins: 30

        SchedualrAlgorithms {
            id: algorithms
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.maximumHeight: 110
            Layout.minimumHeight: 60
            Layout.preferredHeight: 70
            Layout.fillWidth: true
            //            height: 70
            //            anchors.top: parent.top
            //            anchors.topMargin: 30
            //            anchors.left: parent.left
            //            anchors.leftMargin: 50
            //            anchors.right: parent.right
            //            anchors.rightMargin: 50

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
            spacing: 50
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.maximumHeight: 385
            Layout.minimumHeight: 200
            Layout.preferredHeight: 235
            Layout.fillHeight: true
            Layout.fillWidth: true
            //            height: 235
            //            anchors.right: algorithms.right
            //            anchors.left: algorithms.left
            ProcessesQueue {
                id: arrivalQueue
                x: 61
                y: 145
                width: 470
                height: 235
                Layout.maximumHeight: 385
                Layout.minimumHeight: 235
                Layout.preferredHeight: 235
                Layout.maximumWidth: 65000
                Layout.minimumWidth: 500
                Layout.preferredWidth: 500
                Layout.fillWidth: true
                Layout.fillHeight: true

                dim: algorithms.algorithm != 3

                minimumArrivingTime: Schedular.running ? schedular.currentTime +1 : 0
                model: arrivingQueueModel

                enableEdit: !schedular.running
            }


            ReadyQueue {
                id: readyQueue
                x: 565
                y: 175
                width: 235
                height: 235
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.maximumHeight: 385
                Layout.minimumHeight: 235
                Layout.preferredHeight: 235
                Layout.maximumWidth: 65000
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
                Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                Layout.maximumHeight: 385
                Layout.minimumHeight: 235
                Layout.preferredHeight: 235
                Layout.maximumWidth: 65000
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

        Item {
            id: wrapper
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.minimumHeight: 230
            Layout.preferredHeight: 255
            Layout.maximumHeight: 400
            Layout.fillHeight: true
            Layout.fillWidth: true
            Label {
                x: 92
                y: 674
                height: 30
                color: "#bababa"

                text: qsTr("Gant Chartt")
                anchors.verticalCenterOffset: -3
                verticalAlignment: Text.AlignVCenter
                anchors.right: verticalSeparator.left
                anchors.rightMargin: 30
                anchors.verticalCenter: gantChart.verticalCenter
                horizontalAlignment: Text.AlignHCenter
                font.weight: Font.Bold
                font.pixelSize: 20
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
                anchors.right: verticalSeparator.left
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




            ControlBox {
                id: controlBox
                x: 15
                width: 221
                height: 77
                anchors.top: verticalSeparator.top
                anchors.topMargin: 0
                anchors.right: verticalSeparator.left
                anchors.rightMargin: 30

                isRunning: schedular.running
                isPaused: schedular.paused
                onStartClicked:
                {
//                    console.log("onStartClicked ", schedular.running, " " , )
                    if(schedular.paused)
                    {
                        schedular.startSolving()
                    }
                    else
                    {
                        schedular.pause()
                    }


                }
                onStepClicked: schedular.step()

                onStopClicked: {
                    if(schedular.running)
                    {
                        schedular.stop()
                    }
                }
            }




            Rectangle {
                id: verticalSeparator
                x: 307
                width: 1
                color: "#565656"
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 30
                anchors.top: parent.top
                anchors.topMargin: 20
            }

            ProcessDelegate {
                id: currentProcessDelegate
                x: 284
                y: -90
                width: 250
                height: 48
                anchors.verticalCenter: controlBox.verticalCenter
                anchors.left: currentProcessLabel.right
                anchors.leftMargin: 20
                visible: !schedular.idle


                pid: schedular.currentProcess.pid
                arrivalTime: schedular.currentProcess.arrivalTime
                duration: schedular.currentProcess.duration
                priority: schedular.currentProcess.priority
            }

            GantChart{
                id: gantChart
                y: 197
                anchors.bottomMargin: 10
                anchors.bottom: verticalSeparator.bottom
                anchors.left: verticalSeparator.right
                anchors.leftMargin: 30
                anchors.right: parent.right
                anchors.rightMargin: 30

                model: gantChartModel
            }

            Label {
                x: 80
                height: 30
                color: "#bababa"
                text: schedular.currentTime
                anchors.top: controlBox.bottom
                anchors.topMargin: 5
                anchors.right: controlBox.right
                anchors.rightMargin: 0
                font.weight: Font.Bold
                font.pixelSize: 20
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }

            Label {
                id: currentProcessLabel
                y: 54
                width: 172
                height: 30
                color: "#bababa"
                text: qsTr("Current Process")
                anchors.left: verticalSeparator.right
                anchors.leftMargin: 20
                verticalAlignment: Text.AlignVCenter
                anchors.verticalCenterOffset: 0
                font.weight: Font.Bold
                anchors.verticalCenter: controlBox.verticalCenter
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: 20
            }

        }
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





    ListModel{
        id: finishedProcessesModel
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
    D{i:2;anchors_width:138;anchors_x:370;anchors_y:93}D{i:5;anchors_width:138;anchors_x:370}
D{i:6;anchors_width:138;anchors_x:7}D{i:3;anchors_width:138;anchors_x:370}D{i:8;anchors_x:"-98";anchors_y:63}
D{i:9;anchors_x:7}D{i:10;anchors_width:770;anchors_x:7;anchors_y:494}D{i:12;anchors_y:461}
D{i:14;anchors_x:314}D{i:15;anchors_width:770;anchors_x:19}D{i:16;anchors_y:544}D{i:17;anchors_width:770;anchors_x:314;anchors_y:494}
D{i:1;anchors_height:100;anchors_width:138;anchors_x:19;anchors_y:93}D{i:18;anchors_x:"-98";anchors_y:63}
D{i:19;anchors_width:770;anchors_x:19;anchors_y:63}D{i:20;anchors_height:200;anchors_width:179;anchors_x:7;anchors_y:449}
}
##^##*/
