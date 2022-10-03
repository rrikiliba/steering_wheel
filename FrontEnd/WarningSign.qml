import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Image {
    property bool show: false

    id: control
    width: parent.width *0.35; height: width
    opacity: show ? 1 : 0

    Behavior on opacity {
        SequentialAnimation {
            loops: 1
            OpacityAnimator {from: 0; to: 1; duration: 500}
            OpacityAnimator {from: 1; to: 0; duration: 500}
        }
    }
}
