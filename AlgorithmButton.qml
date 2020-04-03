import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

RadioButton {
    id: algorithmButton
    width: 120
    height: 40
    contentItem: Text {
        text: parent.text
        font.pixelSize: 12
        color: "#fffffff0"
        leftPadding: parent.indicator.width + parent.spacing
        verticalAlignment: Text.AlignVCenter
    }
}
