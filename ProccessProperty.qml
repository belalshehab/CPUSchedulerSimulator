import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Item {
    id: root

    property alias minimumValue: spinBox.from
    property alias maximumValue: spinBox.to
    property alias defaultValue: spinBox.value
    property alias name: name.text

    readonly property alias value: spinBox.value

    implicitWidth: 67; implicitHeight: implicitWidth


    SpinBox {
        id: spinBox
        font.weight: Font.Medium
        font.pixelSize: 15

        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right

        from: 0
        to: 1000
        value: from

        editable: true
        wheelEnabled: true
    }
    Label{
        id: name
        anchors.top: parent.top
        horizontalAlignment: Text.AlignHCenter
        anchors.horizontalCenter: parent.horizontalCenter

        font.weight: Font.Bold
        font.pixelSize: 17
        color: "#BABABA"
    }
}
