import QtQuick 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.0

Item
{
    id: root

    property alias radius: borderRec.radius
    property bool transparent: true
    property alias shadowOpacity: shadow.opacity
    property alias shadowRadius: shadow.glowRadius
    property alias shadowSpread: shadow.spread
    property real borderWidth: 1
    property alias borederColor1: borderGradientStop1.color
    property alias borderColor2: borderGradientStop2.color
    property alias fillColor1: fillGradientStop1.color
    property alias fillColor2: fillGradientStop2.color

    implicitWidth: 180
    implicitHeight: 120
    RectangularGlow
    {
        id: shadow
        x: borderRec.x
        y: borderRec.y
        width: borderRec.width
        height: borderRec.height

        color: "black"
        cornerRadius: borderRec.radius + glowRadius
        glowRadius: 4
        opacity: 0.5
        spread: 0.3
    }

    Rectangle
    {
        id: borderRec
        anchors.fill: parent
        width: parent.width - 20
        height: parent.height - 20
        radius: 20
        color: "#141414"
        gradient: Gradient
        {
            id: borderGradient
            GradientStop
            {
                id: borderGradientStop1
                position: 0.0
                color: "#141414"
            }

            GradientStop
            {
                id: borderGradientStop2
                position: 1.0
                color: "transparent"
            }
        }

        Rectangle
        {
            id: backgroundRectangle
            width: parent.width - 2
            height: parent.height - 2
            radius: root.radius
            anchors.centerIn: parent
            color:"#313131"
            gradient: Gradient
            {
                id: fillGradient
                GradientStop
                {
                    id: fillGradientStop1
                    position: 0.0
                    color: "#373737"
                }

                GradientStop
                {
                    id: fillGradientStop2
                    position: 1.0
                    color: "#282828"
                }
            }
        }
    }
}
