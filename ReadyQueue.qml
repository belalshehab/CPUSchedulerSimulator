import QtQuick 2.12
import QtQuick.Controls 2.12

GrayRectangle {

    id: root
    implicitWidth: 350
    implicitHeight: 350

    property alias model: listView.model

    Label {
        id: label

        anchors.right: parent.left
        anchors.left: parent.right
        anchors.top: parent.top

        height: 30

        text: qsTr("Ready Queue")
        anchors.topMargin: 5
        horizontalAlignment: Text.AlignHCenter
        font.weight: Font.Bold
        font.pixelSize: 20
    }


    ListView {
        id: listView
        anchors.topMargin: 5
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.top: label.bottom
        anchors.margins: 15
        clip: true

        verticalLayoutDirection: ListView.BottomToTop

        spacing: 12

        ScrollBar.vertical: ScrollBar{ width: 6}
        delegate: processDelegate

        add: Transition {
            NumberAnimation {
                properties: "x"; from: -listView.width;
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

            color: model.color
        }
    }
}
