import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Dial {
    id: control
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
        color: "white"
        text: dialText
        font.bold: true
        font.pixelSize: 30
        anchors.centerIn: parent
    }

    handle: Rectangle {
        id: handleItem
        x: control.background.x + control.background.width / 2 - width / 2
        y: control.background.y + control.background.height / 2 - height / 2

        width: 10
        height: 20

        color: "red"
        radius: 5
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
