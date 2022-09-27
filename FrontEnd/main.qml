import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15

ApplicationWindow {
    id: root; title: qsTr("Steering Wheel")
    minimumWidth: 800; minimumHeight: 480
    visible: true; color: "#4d4d4d"
    opacity: visibility == Window.Windowed ? 0.9 : 1



    // top section, displaying speed, RPM and limiter percentage
    Rectangle {
        id: topUI
        width: root.width; height: root.height *0.6
        color: "transparent"

        CustomBorder {
            borderColor: "#b3b3b0"; borderThickness: 3; borderSpacing: 5
            rounded: true
        }


        Rectangle {
            height: rpmDial.height *0.75; width: topUI.width -(rpmDial.width *2)
            color: "#3a3a39"
            anchors {
                verticalCenter: rpmDial.verticalCenter
                horizontalCenter: topUI.horizontalCenter
            }

            CustomBorder {
                borderColor: "black"
                borderThickness: 1
            }
        }



        // display for communicating critical value read
        Rectangle {
            id: critDisplay
            color: "#646464"
            width: rpmDial.width *0.6; height: width *0.6
            radius: 6
            anchors {
                horizontalCenter: topUI.horizontalCenter
                verticalCenter: rpmDial.verticalCenter
                verticalCenterOffset: -(width *0.6)
            }

            CustomBorder {
                borderColor: "#b3b3b0"
                borderThickness: parent.width *0.03
                rounded: true

                // listening to valueCritical(..)
                Connections {
                    target: dataSource

                }
            }

        }



        // dial for RPM
        CustomCounter {
            id: rpmDial
            from: 0; to: 15000
            anchors {
                left: topUI.left
                leftMargin: width *0.65
                verticalCenter: topUI.verticalCenter
                verticalCenterOffset: -(width *0.04)
            }

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
            from: 0; to: 120
            anchors {
                right: topUI.right
                rightMargin: width *0.65
                verticalCenter: topUI.verticalCenter
                verticalCenterOffset: -(width *0.04)
            }

            // listening to speedRead(..)
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
            width: rpmDial.width *0.5; height: width
            radius: width *0.5
            anchors {
                horizontalCenter: topUI.horizontalCenter
                top: topUI.verticalCenter
                topMargin: 16
            }

            // listening to limiterRead(..)
            Connections {
                target: dataSource
                onLimiterRead: {
                    limiter.percentage = parseInt(sensorValue *100)
                }
            }

            CustomBorder {
                borderColor: "#b3b3b0"; borderThickness: parent.width *0.03
                rounded: true; borderRadius: parent.width *0.5

                CustomBorder {
                    borderColor: limiter.percentage<40 ? "red" : (limiter.percentage>60 ? "green" : "yellow")
                    borderThickness: parent.borderThickness; borderSpacing: parent.borderThickness *2
                    rounded: true; borderRadius: parent.width *0.5
                }
            }

            Text {
                id: limiterText
                font {
                    pixelSize: limiter.width *0.2
                    bold: true
                }
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
