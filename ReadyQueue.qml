import QtQuick 2.12
import QtQuick.Controls 2.12

GrayRectangle {
    id: root
    width: 200
    height: 333

    property alias model: listView.model

    Label {
        id: label

        anchors.right: parent.left
        anchors.left: parent.right
        anchors.bottom: parent.top

        height: 30

        text: qsTr("Ready Queue")
        horizontalAlignment: Text.AlignHCenter
        font.weight: Font.Bold
        font.pixelSize: 20
    }


    ListView {
        id: listView
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: parent.top
        anchors.margins: 15
        clip: true

        spacing: 10

        ScrollBar.vertical: ScrollBar{ width: 8}
        delegate: processDelegate
    }

    Component {
        id: processDelegate
        ProcessDelegate{

            width: listView.width
            pid: model.pid
            arrivalTime: model.arrivalTime
            duration: model.duration
            priority: model.priority
            selected: true
        }
    }
}
