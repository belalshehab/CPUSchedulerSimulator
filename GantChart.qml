import QtQuick 2.12
import QtQuick.Controls 2.12

Item {
    id:root
    width: 800
    height: 45

    ListModel{
        id: gantChartModel
        ListElement{name: "P1"; width: 50;  time: 0;   color: "red"}
        ListElement{name: "P2"; width: 20;  time: 50;   color: "black"}
        ListElement{name: "P3"; width: 111; time: 70;   color: "green"}
        ListElement{name: "P4"; width: 30;  time: 181;   color: "orange"}
        ListElement{name: "P5"; width: 70;  time: 211;   color: "blue"}


        ListElement{name: "P1"; width: 50;  time: 0;   color: "red"}
        ListElement{name: "P2"; width: 20;  time: 50;   color: "black"}
        ListElement{name: "P3"; width: 111; time: 70;   color: "green"}
        ListElement{name: "P4"; width: 30;  time: 181;   color: "orange"}
        ListElement{name: "P5"; width: 70;  time: 211;   color: "blue"}
        ListElement{name: "P1"; width: 50;  time: 0;   color: "red"}
        ListElement{name: "P2"; width: 20;  time: 50;   color: "black"}
        ListElement{name: "P3"; width: 111; time: 70;   color: "green"}
        ListElement{name: "P4"; width: 30;  time: 181;   color: "orange"}
        ListElement{name: "P5"; width: 70;  time: 211;   color: "blue"}


        ListElement{name: "P1"; width: 50;  time: 0;   color: "red"}
        ListElement{name: "P2"; width: 20;  time: 50;   color: "black"}
        ListElement{name: "P3"; width: 111; time: 70;   color: "green"}
        ListElement{name: "P4"; width: 30;  time: 181;   color: "orange"}
        ListElement{name: "P5"; width: 70;  time: 211;   color: "blue"}

    }

    ListView {
        id: gantChartView
        orientation: ListView.Horizontal
        flickableDirection: Flickable.HorizontalFlick

        anchors.fill: parent
        boundsMovement: Flickable.StopAtBounds
        boundsBehavior: Flickable.StopAtBounds
        model: gantChartModel
        delegate: gantChartDelegate
        clip: true

    }

    Component{
        id:gantChartDelegate
        Rectangle {
            height: gantChartView.height -20
            color: model.color
            width: model.width

            Label{
                anchors.centerIn: parent
                text: model.name
            }

            Label{
                anchors.top: parent.bottom
                text: model.time
            }
        }
    }


}
