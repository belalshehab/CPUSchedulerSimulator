import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

RadioButton {
    id: algorithmButton
    implicitWidth: 120
    implicitHeight: 40

    contentItem: Text {
        text: parent.text
        font.weight: Font.Bold
        font.pixelSize: 21
        font.family: "Roboto"
        color: "#bababa"
        leftPadding: parent.indicator.width + parent.spacing
        verticalAlignment: Text.AlignVCenter
    }
}
