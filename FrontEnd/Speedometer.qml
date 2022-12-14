import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Dial {
    property string dialText: Math.round(value * 100) / 100

    id: control
    width: parent.width *0.26; height: width

    background: Image {
        source: "Files/dial.png"

        x: (control.width -width) *0.5
        y: (control.height -height) *0.5

        sourceSize.width: control.width
        sourceSize.height: control.height

        width: control.width
        height: control.width
    }

    Text {
        text: dialText
        font {
            bold: true
            pixelSize: control.width *0.15
        }
        color: "white"
        anchors.centerIn: parent
    }

    handle: Rectangle {
        id: handleItem
        x: control.background.x + (control.background.width -width) *0.5
        y: control.background.y + (control.background.height - height) *0.5

        width: control.width *0.05; height: width *3

        color: "red"
        radius: width *0.5
        antialiasing: true

        transform: [
            Translate {
                y: -Math.min(control.background.width, control.background.height) * 0.4 + handleItem.height *0.5
            },
            Rotation {
                angle: control.angle
                origin.x: handleItem.width *0.5
                origin.y: handleItem.height *0.5
            }
        ]
    }
}
