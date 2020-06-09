import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

import scheduler 0.1


ApplicationWindow {
    id: applicationWindow
    visible: true
    width: 1200
    height: 720


    color: "#333333"

    title: "CPU scheduler"

    property int currentArivingIndex: 0

    function enqueue(current = false)
    {
        var readyQueueIndex;
        if(current)
        {
            readyQueueIndex = scheduler.enqueueArrivedProccess(scheduler.currentProcess)
            readyQueueModel.insert(readyQueueIndex, scheduler.currentProcess)
            return;
        }

        while(currentArivingIndex < arrivingQueueModel.count)
        {
            var p = arrivingQueueModel.get(currentArivingIndex)
            scheduler.currentProcess.color = p.color

            readyQueueIndex = scheduler.enqueueArrivedProccess(p)
            if(readyQueueIndex < 0)
            {
                break;
            }

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

            enabled: !scheduler.running


            onAlgorithmChanged: {
                switch(algorithms.algorithm)
                {
                case Scheduler.SJF:
                    readyQueueModel.sortingOn = ProcessesQueueModel.DURATION
                    break;
                case Scheduler.PRIORITY:
                    readyQueueModel.sortingOn = ProcessesQueueModel.PRIORITY
                    break;
                default:
                    readyQueueModel.sortingOn = ProcessesQueueModel.ARRIVAL
                }
            }
        }

        Item{
            Layout.minimumWidth: 1070
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            Layout.maximumHeight: 385
            Layout.minimumHeight: 200
            Layout.preferredHeight: 235
            Layout.fillHeight: true
            Layout.fillWidth: true
            RowLayout{
                id: rowLayout
                anchors.fill: parent
                spacing: 50
                ProcessesQueue {
                    id: arrivalQueue
                    x: 61
                    y: 145
                    width: 470
                    height: 235
                    Layout.maximumHeight: 385
                    Layout.minimumHeight: 235
                    Layout.preferredHeight: 235
                    Layout.maximumWidth: 770
                    Layout.minimumWidth: 500
                    Layout.preferredWidth: 500
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    dim: algorithms.algorithm != 3

                    minimumArrivingTime: Scheduler.running ? scheduler.currentTime +1 : 0
                    model: arrivingQueueModel

                    enableEdit: !scheduler.running
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
                    Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
                    Layout.maximumHeight: 385
                    Layout.minimumHeight: 235
                    Layout.preferredHeight: 235
                    Layout.maximumWidth: 385
                    Layout.minimumWidth: 235
                    Layout.preferredWidth: 235
                    Layout.fillWidth: true
                    Layout.fillHeight: true

                    averageTurnaroundTime: Math.round(scheduler.averageTurnaroundTime *100) /100
                    averageResponseTime: Math.round(scheduler.averageResponseTime *100) /100
                    averageWaitingTime: Math.round(scheduler.averageWaitingTime *100) /100

                    idleTime: scheduler.idleTime
                }
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

                text: qsTr("Gantt Chart")
                anchors.verticalCenterOffset: -3
                verticalAlignment: Text.AlignVCenter
                anchors.right: verticalSeparator.left
                anchors.rightMargin: 30
                anchors.verticalCenter: ganttChart.verticalCenter
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
            GanttChart {
                id: finishedProcesses

                anchors.bottom: ganttChart.top
                anchors.right: ganttChart.right
                anchors.left: ganttChart.left
                anchors.bottomMargin: 20

                clickable: true
                model: finishedProcessesModel

                onClick: {
                    processDetails.open()

                    var process = scheduler.getFinishedProcess(index)
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

                enabled: !arrivingQueueModel.isEmpty
                isRunning: scheduler.running
                isPaused: scheduler.paused
                onStartClicked:
                {
                    if(scheduler.paused)
                    {
                        scheduler.startSolving()
                    }
                    else
                    {
                        scheduler.pause()
                    }


                }
                onStepClicked: scheduler.step()

                onStopClicked: {
                    if(scheduler.running)
                    {
                        scheduler.stop()
                    }
                }
            }




            Rectangle {
                id: verticalSeparator
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 30
                anchors.top: parent.top
                anchors.topMargin: 20
                x: 307
                width: 1
                color: "#565656"
            }

            ProcessDelegate {
                id: currentProcessDelegate       
                x: 530
                y: 44

                width: 210
                height: 30

                visible: !scheduler.idle

                property int animationDuration: 150
                onPidChanged: {
                    animatY.start()
                    animatX.start()
                    animatOpacity.start()
                }

                NumberAnimation on opacity{
                    id: animatOpacity
                    from: 0
                    to: 1
                    duration: currentProcessDelegate.animationDuration
                    easing.type: Easing.InOutQuad
                }

                NumberAnimation on y{
                    id: animatY
                    from: 0
                    to: 44
                    duration: currentProcessDelegate.animationDuration
                    easing.type: Easing.InOutQuad
                }

                NumberAnimation on x{
                    id: animatX
                    from: currentProcessDelegate.width + 530
                    to: 530
                    duration: currentProcessDelegate.animationDuration
                    easing.type: Easing.InOutQuad
                }

                pid: scheduler.currentProcess.pid
                arrivalTime: scheduler.currentProcess.arrivalTime
                duration: scheduler.currentProcess.duration
                priority: scheduler.currentProcess.priority
                color: scheduler.currentProcess.color
            }

            GanttChart{
                id: ganttChart
                anchors.bottomMargin: 10
                anchors.bottom: verticalSeparator.bottom
                anchors.left: verticalSeparator.right
                anchors.leftMargin: 30
                anchors.right: parent.right
                anchors.rightMargin: 30

                model: gantChartModel
            }

            Label {
                anchors.top: controlBox.bottom
                anchors.topMargin: 5
                anchors.right: controlBox.right

                height: 30

                text: scheduler.currentTime
                color: "#bababa"

                font.weight: Font.Bold
                font.pixelSize: 20
                verticalAlignment: Text.AlignVCenter
                horizontalAlignment: Text.AlignRight
            }

            Label {
                id: currentProcessLabel
                anchors.left: ganttChart.left
                anchors.verticalCenter: controlBox.verticalCenter

                width: 172
                height: 30

                text: qsTr("Current Process")
                color: "#bababa"
                verticalAlignment: Text.AlignVCenter
                font.weight: Font.Bold
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: 20
            }

            Rectangle {
                id: horizontalSeparator
                anchors.verticalCenter: controlBox.bottom
                anchors.left: ganttChart.left
                anchors.right: parent.right

                height: 1
                color: "#565656"
            }

        }
    }


    Scheduler{
        id: scheduler
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
                gantChartModel.append({name: "", width: 0,  time: currentTime, r: 0,   g: 0,  b: 0,   a: 0})
            }
            else
            {
                gantChartModel.append({name: "P" + scheduler.currentProcess.pid, width: 0,  time: currentTime,
                                          r: scheduler.currentProcess.color.r,   g: scheduler.currentProcess.color.g,
                                          b: scheduler.currentProcess.color.b,   a: scheduler.currentProcess.color.a})
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
                gantChartModel.append({name: "" , width: 5,  time: currentTime, r: 0,   g: 0,  b: 0,   a: 0})
            }
        }

        onFinishedProcessesChanged: {
            var x = lastFinishedProcess()
            finishedProcessesModel.append({"name": "P" + x.pid, "width": x.originalDuration *20 ,  "time": currentTime,
                                              r: scheduler.currentProcess.color.r,   g: scheduler.currentProcess.color.g,
                                              b: scheduler.currentProcess.color.b,   a: scheduler.currentProcess.color.a})
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
