import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Item {
    id: root

    property alias minimumValue: spinBox.from
    property alias maximumValue: spinBox.to
    property alias defaultValue: spinBox.value
    property alias name: text.text

    readonly property alias value: spinBox.value

    Layout.maximumWidth: 150
    Layout.minimumWidth: 125
    Layout.preferredWidth: 125
    Layout.maximumHeight: 70
    Layout.minimumHeight: 60
    Layout.preferredHeight: 60
    Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
    Layout.fillHeight: true
    Layout.fillWidth: true
    SpinBox {
        id: spinBox
        editable: true
        wheelEnabled: true

        value: 0
        from: 0
        to: 1000
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
    }
    Label{
        id: text
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
