import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    id:root
    width: 800
    height: 38

    clip: true
    property alias model: gantChartView.model

    property bool clickable: false
    property int index
    signal click


    ListView {
        id: gantChartView
        anchors.rightMargin: 10
        anchors.leftMargin: 10

        orientation: ListView.Horizontal
        flickableDirection: Flickable.HorizontalFlick

        anchors.fill: parent
        boundsMovement: Flickable.StopAtBounds
        boundsBehavior: Flickable.StopAtBounds

        spacing: 4
        delegate: gantChartDelegate

        highlightRangeMode: ListView.ApplyRange

        currentIndex: model.count -1
    }

    Component{
        id:gantChartDelegate
        Rectangle {
            height: gantChartView.height -20
            color: Qt.rgba(model.r, model.g, model.b, model.a)
            width: model.width

            Label{
                anchors.centerIn: parent
                text: model.name

                font.weight: Font.Bold
                font.pixelSize: 13
                font.family: "ROBOTO"
            }

            Label{
                visible: !clickable
                anchors.top: parent.bottom
                text: model.time

                font.pixelSize: 13
                font.family: "ROBOTO"
            }
            MouseArea{
                anchors.fill: parent
                enabled: clickable
                onClicked: {
                    root.index = index
                    click()
                }
            }

            Behavior on width{NumberAnimation{duration: 200; easing.type: Easing.InOutCubic}}
        }

    }


}
