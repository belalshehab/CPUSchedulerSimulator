import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.2

GrayRectangle {
    id: root
    implicitWidth: 600
    implicitHeight: 255

    property alias model: listView.model
    property int minimumArrivingTime: 0
    property bool dim: false
    property bool enableEdit: true

    RowLayout {
        id: rowLayout
        height: 70
        anchors.top: parent.top
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.rightMargin: 30
        anchors.right: parent.right
        spacing: 10

        enabled: enableEdit
        Button {
            id: addButton
            text: qsTr("Add")
            Layout.minimumWidth: 40
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
            font.pixelSize: 12

            onClicked: {
                root.model.add(arrivalTime.value, duration.value, priority.value)
            }
        }

        Button{
            id: clearButton
            text: qsTr("Clear")
            Layout.minimumWidth: 55
            Layout.fillWidth: true
            font.pixelSize: 12
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            onClicked: listView.model.clear()
        }

        ProccessProperty {
            id: arrivalTime
            minimumValue: minimumArrivingTime
            name: qsTr("Arrival")
            Layout.minimumWidth: 105
            defaultValue: 0
            Layout.preferredWidth: 120
            Layout.fillHeight: true
            Layout.fillWidth: true
        }

        ProccessProperty {
            id: duration
            minimumValue: 1
            defaultValue: 1
            name: qsTr("Duration")
            Layout.minimumWidth: 105
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.preferredWidth: 120
        }

        ProccessProperty {
            id: priority
            maximumValue: 7
            name: qsTr("Priority")
            Layout.minimumWidth: 105
            Layout.preferredWidth: 120
            Layout.fillHeight: true
            Layout.fillWidth: true

            opacity: dim ? 0.3 : 1
        }
    }

    Rectangle{
        anchors.top: rowLayout.bottom
        anchors.left: rowLayout.left
        anchors.right: rowLayout.right
        height: 1
        color: "#BFBFBF"
        opacity: 0.5
    }

    ListView {
        id: listView
        anchors.leftMargin: 20
        anchors.topMargin: 10
        anchors.right: rowLayout.right
        anchors.bottomMargin: 10
        anchors.left: rowLayout.left
        anchors.bottom: parent.bottom
        anchors.top: rowLayout.bottom
        anchors.margins: 15
        clip: true
        spacing: 12

        ScrollBar.vertical: ScrollBar{ width: 6}
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
            width: listView.width - 7
            pid: model.pid
            arrivalTime: model.arrivalTime
            duration: model.duration
            priority: model.priority

            editable: enableEdit

            onColorClicked: {
                listView.currentIndex = index
                colorDialog.open()
            }
            onLeftClicked: {
                listView.currentIndex = index
            }
            onDeleteClicked: root.model.remove(index)
        }
    }


    ColorDialog {
        id: colorDialog
        title: "Please choose a color"
        onAccepted: {
            return listView.currentItem.pColor = colorDialog.color
        }
    }



}

/*##^##
Designer {
    D{i:15;anchors_width:140;anchors_x:84}
}
##^##*/
