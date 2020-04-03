import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Item {
    id: root

    readonly property alias value: slider.value

    Label {
        id: label
        height: 20
        text: qsTr("Quanta")
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        horizontalAlignment: Text.AlignHCenter
        color: "#fffffff0"
    }

    Slider {
        id: slider
        y: 37
        height: 23

        anchors.leftMargin: 20
        stepSize: 1
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        from: 1
        to: 20
        value: Math.round((to - from ) /2)


        enabled: opacity

        Label{
            id: value
            text: parent.value
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.left
            anchors.rightMargin: 10
            color: "#fffffff0"
        }
    }
    
    Behavior on opacity { NumberAnimation{duration: 200} }
}
