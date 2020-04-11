import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.2

GrayRectangle {
    id: root
    width: 350
    height: 270

    property alias model: listView.model
    property int minimumArrivingTime: 0
    property bool dim: false

    Label {
        id: label3

        anchors.right: root.left
        anchors.left: root.right
        anchors.bottom: root.top


        height: 30
        text: qsTr("User Input")
        horizontalAlignment: Text.AlignHCenter
        font.weight: Font.Bold
        font.pixelSize: 20
    }

    ListView {
        id: listView
        width: 158
        anchors.bottomMargin: 5
        anchors.left: parent.left
        anchors.bottom: clearButton.top
        anchors.top: parent.top
        anchors.margins: 15
        clip: true
        spacing: 12

        ScrollBar.vertical: ScrollBar{ width: 8}
        delegate: processDelegate


        add: Transition {
            NumberAnimation {
                properties: "x"; from: listView.width;
                duration: 150; easing.type: Easing.InCirc
            }
            NumberAnimation { properties: "height"; from: 0;
                duration: 200; easing.type: Easing.InCirc
            }
        }
        remove: Transition {
            NumberAnimation {
                properties: "x"; to: listView.width;
                duration: 150; easing.type: Easing.OutCubic
            }
        }
        removeDisplaced: Transition {
            SequentialAnimation {
                PauseAnimation { duration: 150 }
                NumberAnimation { properties: "y"; duration: 75
                }
            }
        }
    }


    Component {
        id: processDelegate
        ProcessDelegate{

            width: listView.width - 10
            pid: model.pid
            arrivalTime: model.arrivalTime
            duration: model.duration
            priority: model.priority
            selected: true
            onColorClicked: {
                listView.currentIndex = index
                colorDialog.open()
            }
            onLeftClicked: {
                //                listView.currentItem.selected = false
                listView.currentIndex = index
            }
            onDeleteClicked: arrivingQueueModel.remove(index)
        }
    }


    ColumnLayout {
        id: columnLayout
        x: 84
        width: 140
        anchors.rightMargin: 15
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        spacing: 10

        ProccessProperty {
            id: arrivalTime
            minimumValue: minimumArrivingTime
            name: qsTr("Arrival time")
        }

        ProccessProperty {
            id: duration
            minimumValue: 1
            defaultValue: 1
            name: qsTr("Duration")
        }

        ProccessProperty {
            id: priority
            maximumValue: 7
            name: qsTr("Priority")

            opacity: dim ? 0.3 : 1
        }

        Button {
            id: addButton
            text: qsTr("Add")
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            font.pixelSize: 12

            onClicked: {
                arrivingQueueModel.add(arrivalTime.value, duration.value, priority.value)
            }
        }
    }



    ColorDialog {
        id: colorDialog
        title: "Please choose a color"
        onAccepted: {
            return listView.currentItem.pColor = colorDialog.color
        }
    }


    Button{
        id: clearButton

        anchors.right: listView.right
        anchors.left: listView.left
        anchors.bottom: parent.bottom

        height: 48

        text: qsTr("Clear")
        font.pixelSize: 12
        Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

        onClicked: listView.model.clear()
    }
}
