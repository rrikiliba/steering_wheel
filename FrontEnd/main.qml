import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    id: root
    width: 800
    height: 480
    visible: true
    title: qsTr("Steering Wheel")



    // top section, displaying speed, RPM and limiter percentage
    Rectangle {
        id: topUI
        width: root.width
        height: root.height *0.6
        color: "#404040"

        CustomBorder {
            borderColor: "#ffec01"
            borderThickness: 3
            borderSpacing: 5
            rounded: true
        }

            Text {
                id: testText
                color: "white"
                text: "0"
                font.pixelSize: 40
                anchors.centerIn: parent

                Connections {
                    target: dataSource;
                    onValueChanged: {
                        testText.text = value.toFixed(2)
                        testText.color = "white"
                    }
                    onValueCritical: testText.color = "red"
                }
            }
     }



    // bottom-left section, displaying voltage-type sensor readings
    Rectangle {
        id: voltageUI
        y: topUI.height
        width: root.width *0.5
        height: root.height *0.4
        color: "#404040"

        CustomBorder {
            borderColor: "#ffec01"
            borderThickness: 3
            borderSpacing: 5
            rounded: true
        }
    }




    // bottom-right section, displaying temperature-type sensor readings
    Rectangle {
        id: thermalsUI
        x: voltageUI.width
        y: topUI.height
        width: root.width *0.5
        height: root.height *0.4
        color: "#404040"

        CustomBorder {
            borderColor: "#ffec01"
            borderThickness: 3
            borderSpacing: 5
            rounded: true
        }
    }
}
