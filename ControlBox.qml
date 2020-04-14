import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12


//Item {
Rectangle{
    color: "#333333"
    id: root
    property alias speed: speedSlider.value

    property int currentTime: 0

    property bool isRunning: false
    property bool isPaused: true

    signal startClicked
    signal stopClicked
    signal stepClicked

    width: 445
    height: 100
    


    
    ColumnLayout{
        anchors.fill: parent


        RowLayout {
            id: buttonsLayout
            Layout.fillHeight: true
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

            Button {
                id: stopButton

                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                display: AbstractButton.IconOnly
                icon.source: "icons/stopButton.svg"

                opacity: isRunning ? 1 : 0.3


                onClicked:
                {
                    if(isRunning)
                    {
                        stopClicked()

                    }
                }
            }

            Button {
                id: startButton
                Layout.fillHeight: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter
                Layout.fillWidth: true

                display: AbstractButton.IconOnly
                icon.source: isPaused ? "icons/playButton.svg" : "icons/pauseButton.svg"

                onClicked: {
                    startClicked()
                }
            }

            Button {
                id: stepButton
                Layout.fillHeight: true
                Layout.fillWidth: true
                Layout.alignment: Qt.AlignHCenter | Qt.AlignVCenter

                display: AbstractButton.IconOnly
                icon.source: "icons/stepButton.svg"

                enabled: isPaused
                onClicked: {
                    stepClicked()
                }
            }

        }

        Slider {
            id: speedSlider
            Layout.maximumHeight: 35
            Layout.minimumHeight: 25
            Layout.preferredHeight: 30
            Layout.fillHeight: false
            Layout.fillWidth: true

            value: 1
            stepSize: 0.1
            from: 2; to: 0.1
        }
    }
    Rectangle {
        id: horizontalSeparator
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        height: 1
        color: "#565656"
    }

}
