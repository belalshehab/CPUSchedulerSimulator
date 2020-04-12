import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Item {
    id: root

    readonly property alias value: slider.value

    opacity: enabled ? 1 : 0.3
    Slider {
        id: slider

        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.left: value.right
        anchors.leftMargin: 5

        height: 25
        stepSize: 1
        from: 1
        to: 20
        value: Math.round((to - from ) /2)

    }
    Label{
        id: value
        anchors.left: parent.left
        anchors.verticalCenter: parent.verticalCenter

        text: parent.value

        font.pixelSize: 20
        font.family: "Roboto"
        color: "#fffffff0"
    }
    
    Behavior on opacity { NumberAnimation{duration: 200} }
}
