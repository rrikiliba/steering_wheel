import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

Window {
    id: root
    title: qsTr("Steering Wheel")
    minimumWidth: 800
    minimumHeight: 480
    visible: true
    color: "#4d4d4d"
    opacity: 0.9

    // top section, displaying speed, RPM and limiter percentage
    Rectangle {
        id: topUI
        width: root.width
        height: root.height *0.6
        color: "transparent"

        CustomBorder {
            borderColor: "#b3b3b0"
            borderThickness: 3
            borderSpacing: 5
            rounded: true
        }

        // display for communicating critical value read
        Rectangle {
            id: critDisplay
            color: "#646464"
            width: rpmDial.width *1.8
            height: width *0.36
            anchors.horizontalCenter: topUI.horizontalCenter
            anchors.verticalCenter: rpmDial.verticalCenter
            anchors.verticalCenterOffset: -20

            CustomBorder {
                borderColor: "#b3b3b0"
                borderThickness: 5

                // listening to valueCritical(..)
                Connections {
                    target: dataSource

                }
            }

        }

        // dial for RPM
        CustomCounter {
            id: rpmDial
            from: 0
            to: 15000

            // setting position and dimentions
            width: parent.width *0.25
            height: width
            anchors.left: topUI.left
            anchors.leftMargin: width *0.6
            anchors.verticalCenter: topUI.verticalCenter
            anchors.verticalCenterOffset: -20

            // listening to rpmRead(..)
            Connections {
                target: dataSource;
                onRpmRead: {
                    rpmDial.value = sensorValue;
                    rpmDial.dialText = Math.round(sensorValue * 100) / 100;
                }
            }
        }


        // dial for speed
        CustomCounter {
            id: speedDial
            from: 0
            to: 120

            // setting position and dimentions
            width: parent.width *0.25
            height: width
            anchors.right: topUI.right
            anchors.rightMargin: width *0.6
            anchors.verticalCenter: topUI.verticalCenter
            anchors.verticalCenterOffset: -20

            // listening to rpmRead(..)
            Connections {
                target: dataSource;
                onSpeedRead: {
                    speedDial.value = sensorValue;
                    speedDial.dialText = Math.round(sensorValue * 100) / 100;
                }
            }
        }


        // smaller section for limiter percentage
        Rectangle {
            id: limiter
            property int percentage: 0
            color: "#646464"
            width: rpmDial.width *0.4
            height: width
            radius: width *0.5
            anchors.horizontalCenter: topUI.horizontalCenter
            anchors.top: critDisplay.bottom
            anchors.topMargin: -8

            // listening to limiterRead(..)
            Connections {
                target: dataSource
                onLimiterRead: {
                    limiter.percentage = parseInt(sensorValue *100)
                }
            }

            CustomBorder {
                borderColor: "#b3b3b0"
                borderThickness: 5
                rounded: true
                borderRadius: parent.width *0.5

                CustomBorder {
                    borderColor: limiter.percentage<40 ? "red" : (limiter.percentage>60 ? "green" : "yellow")
                    borderThickness: 2
                    borderSpacing: 6
                    rounded: true
                    borderRadius: parent.width *0.5
                }
            }

            Text {
                id: limiterText
                font.pixelSize: 20
                font.bold: true
                color: "white"
                anchors.centerIn: parent
                text: limiter.percentage+"%"
            }
        }
   }













    // bottom-left section, displaying voltage-type sensor readings
    Rectangle {
        id: voltageUI
        anchors.top: topUI.bottom
        width: root.width *0.5
        height: root.height *0.4
        color: "transparent"

        CustomBorder {
            borderColor: "#b3b3b0"
            borderThickness: 3
            borderSpacing: 5
            rounded: true
        }
    }














    // bottom-right section, displaying temperature-type sensor readings
    Rectangle {
        id: thermalsUI
        anchors.left: voltageUI.right
        anchors.top: topUI.bottom
        width: root.width *0.5
        height: root.height *0.4
        color: "transparent"

        CustomBorder {
            borderColor: "#b3b3b0"
            borderThickness: 3
            borderSpacing: 5
            rounded: true
        }
    }
}
