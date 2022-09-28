import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Dial {
    id: control
    width: parent.width *0.26; height: width
    property string dialText: "0"

    background: Image {
        source: "Files/dial.png"

        x: control.width / 2 - width / 2
        y: control.height / 2 - height / 2

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
        x: control.background.x + control.background.width / 2 - width / 2
        y: control.background.y + control.background.height / 2 - height / 2

        width: control.width *0.05; height: width *3

        color: "red"
        radius: width *0.5
        antialiasing: true

        transform: [
            Translate {
                y: -Math.min(control.background.width, control.background.height) * 0.4 + handleItem.height / 2
            },
            Rotation {
                angle: control.angle
                origin.x: handleItem.width / 2
                origin.y: handleItem.height / 2
            }
        ]
    }
}
