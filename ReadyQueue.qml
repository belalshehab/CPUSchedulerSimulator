import QtQuick 2.12
import QtQuick.Controls 2.12

GrayRectangle {
    id: root
    width: 234
    height: 333

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
        ListElement{pid: 1; arrivalTime: 0; duration: 5; priority: 0}
        ListElement{pid: 2; arrivalTime: 2; duration: 4; priority: 1}
        ListElement{pid: 3; arrivalTime: 4; duration: 6; priority: 4}
        ListElement{pid: 4; arrivalTime: 4; duration: 2; priority: 0}
    }

    Component {
        id: processDelegate
        ProcessDelegate{

            width: listView.width
            pid: model.pid
            arrivalTime: model.arrivalTime
            duration: model.duration
            priority: model.priority
            selected: false
        }
    }
}
