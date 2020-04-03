import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.2

GrayRectangle {
    id: root
    width: 350
    height: 270

    property bool dim: false
    ListView {
        id: listView
        width: 158
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.margins: 15
        clip: true
        model: theModel

        spacing: 3

        ScrollBar.vertical: ScrollBar{ width: 8}
        delegate: processDelegate
    }

    ListModel{
        id: theModel
    }

    Component {
        id: processDelegate
        ProcessDelegate{

            width: listView.width
            pid: model.pid
            arrivalTime: model.arrivalTime
            duration: model.duration
            priority: model.priority
            selected: index == listView.currentIndex
            MouseArea{
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: {
                    if (mouse.button === Qt.RightButton)
                        theModel.remove(index)
                    else
                        listView.currentIndex = index
                }
                onDoubleClicked: {
                    if (mouse.button === Qt.LeftButton)
                        colorDialog.open()

                }
            }
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
                theModel.append({"pid": theModel.count +1, "arrivalTime": arrivalTime.value, "duration": duration.value, "priority": priority.value})
            }
        }

    }



    ColorDialog {
        id: colorDialog
        title: "Please choose a color"
        onAccepted: {
            console.log("You chose: " + colorDialog.color)
            Qt.quit()
        }
        onRejected: {
            console.log("Canceled")
            Qt.quit()
        }
    }
}
