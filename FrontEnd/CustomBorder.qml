import QtQuick 2.15
import QtQuick.Window 2.15

Rectangle {

    property string borderColor: "white"
    property string insideColor: parent.color
    property int borderThickness: 2
    property int borderSpacing: 1
    property bool rounded: false

    id: base
    width: parent.width-borderSpacing
    height: parent.height-borderSpacing
    anchors.centerIn: parent
    color:  borderColor
    radius: rounded ? 5 : 0

    Rectangle {
        width: base.width-borderThickness
        height: base.height-borderThickness
        anchors.centerIn: base
        color: insideColor
        radius: base.rounded ? 5 : 0
    }
}
