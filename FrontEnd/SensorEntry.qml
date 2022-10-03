import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Rectangle {
    property real from: 0
    property real to: 100
    property real value: 0
    property real displayValue: (control.value -control.from) /(control.to -control.from) *frame.width
    property string entryColor: "white"
    property string entryName: ""
    property string entryUnit: "C"

    id: control
    width: parent.width *0.8; height: parent.height *0.2
    anchors.horizontalCenter: parent.horizontalCenter
    color: "transparent"



    Text {

        anchors {
            left: control.left
            verticalCenter: control.verticalCenter
        }

        font {
            pixelSize: control.height *0.6
            bold: true
        }

        horizontalAlignment: Text.AlignRight
        color: "white"
        text: entryName + "  " +(Math.round(control.value * 100) / 100) +control.entryUnit
    }

    Rectangle {
        id: frame
        color: "#4d4d4d"; radius: 5
        height: control.height *0.2; width: control.width *0.4

        anchors {
            right: control.right
            verticalCenter: control.verticalCenter
        }

        Rectangle {
            color: control.entryColor; radius: 5

            Behavior on color {
                SequentialAnimation {
                    loops: 1
                    ColorAnimation { from: "white"; to: "red"; duration: 500 }
                    ColorAnimation { from: "red"; to: "white";  duration: 1000 }
                 }
            }

            anchors.left: frame.left
            height: frame.height
            width: control.displayValue < frame.width ? control.displayValue : frame.width
        }
    }
}
