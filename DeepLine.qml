import QtQuick 2.12

Item
{
    id: root
    height: 2

    Rectangle
    {
        id: topLine
        anchors.centerIn: parent
        width: parent.width;
        height: parent.height /2
        color: "#191919"
    }

    Rectangle
    {
        id: bottomLine
        width: parent.width;
        height: parent.height /2
        color: "#515151"
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 1
    }
}
