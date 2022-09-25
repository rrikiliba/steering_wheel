import QtQuick 2.15
import QtQuick.Window 2.15

Rectangle {

    property string borderColor: "red"
    property int borderThickness: 2
    property int borderSpacing: 1
    property bool rounded: false
    property int borderRadius: 5

    color: "transparent"
    border.color: borderColor

    border.width: borderThickness
    radius: rounded ? borderRadius : 0

    width: parent.width -borderSpacing
    height: parent.height -borderSpacing
    anchors.centerIn: parent
}
