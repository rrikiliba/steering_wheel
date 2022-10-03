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



        // dial for RPM
        Speedometer {
            id: rpmDial
            from: 0; to: 15000
            anchors {
                left: topUI.left
                leftMargin: width *0.65
                top: topUI.top
                topMargin: width *0.12
            }

            // listening to rpmRead(..)
            Connections {
                target: dataSource;
                onRpmRead: rpmDial.value = sensorValue
            }
        }



        // dial for speed
        Speedometer {
            id: speedDial
            from: 0; to: 120
            anchors {
                right: topUI.right
                rightMargin: width *0.65
                verticalCenter: rpmDial.verticalCenter
            }

            // listening to speedRead(..)
            Connections {
                target: dataSource;
                onSpeedRead: speedDial.value = sensorValue
            }
        }



        // decorative element, don't mind me
        Rectangle {
            id: bridge; z: -1
            height: rpmDial.height *0.75; width: topUI.width -(rpmDial.width *2)
            gradient: Gradient {
                GradientStop {position: 0.0; color: "#4d4d4d"}
                GradientStop {position: 1.0; color: "#3a3a39"}
            }

            anchors {
                verticalCenter: rpmDial.verticalCenter
                horizontalCenter: parent.horizontalCenter
            }

            CustomBorder {
                borderColor: "black"
                borderThickness: 1
            }
        }



        // smaller section for limiter percentage
        Rectangle {
            id: limiter
            property int percentage: 0
            gradient: Gradient {
                GradientStop {position: 0.0; color: "#646464"}
                GradientStop {position: 1.0; color: "#4d4d4d"}
            }
            width: rpmDial.width *0.5; height: width
            radius: width *0.5
            anchors {
                horizontalCenter: topUI.horizontalCenter
                top: bridge.bottom; topMargin: - width *0.5
            }

            // listening to limiterRead(..)
            Connections {
                target: dataSource
                onLimiterRead: limiter.percentage = parseInt(sensorValue *100)

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



        // display for critical value read
        Rectangle {
            id: critDisplay
            gradient: Gradient {
                GradientStop {position: 0.0; color: "#646464"}
                GradientStop {position: 1.0; color: "#4d4d4d"}
            }
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
            }

            WarningSign {
                id: alertVoltage; source: "Files/alertVoltage.png"
                anchors {
                    verticalCenter: critDisplay.verticalCenter
                    left: critDisplay.left; leftMargin: critDisplay.width *0.1
                }
            }

            WarningSign {
                id: alertTemperature; source: "Files/alertTemperature.png"
                anchors {
                    verticalCenter: critDisplay.verticalCenter
                    right: critDisplay.right; rightMargin: critDisplay.width *0.1
                }
            }

            // listening to valueCritical(..)
            Connections {
                target: dataSource
                onValueCritical: {

                    switch(sensorID){
                    // sensors from 0 to 2 do not currently generate critical data
                    case 3:
                        bmshvTemperatureEntry.entryColor = "red"
                        bmshvTemperatureEntry.entryColor = "white"
                        alertTemperature.show = true
                        alertTemperature.show = false
                        // have to set parameters to one value and immediately the other to play the animation
                        break;
                    case 4:
                        bmslvTemperatureEntry.entryColor = "red"
                        bmslvTemperatureEntry.entryColor = "white"
                        alertTemperature.show = true
                        alertTemperature.show = false
                        break;
                    case 5:
                        inverterTemperatureEntry.entryColor = "red"
                        inverterTemperatureEntry.entryColor = "white"
                        alertTemperature.show = true
                        alertTemperature.show = false
                        break;
                    case 6:
                        motorTemperatureEntry.entryColor = "red"
                        motorTemperatureEntry.entryColor = "white"
                        alertTemperature.show = true
                        alertTemperature.show = false
                        break;
                    case 7:
                        bmshvVoltageEntry.entryColor = "red"
                        bmshvVoltageEntry.entryColor = "white"
                        alertVoltage.show = true
                        alertVoltage.show = false
                        break;
                    case 8:
                        bmslvVoltageEntry.entryColor = "red"
                        bmslvVoltageEntry.entryColor = "white"
                        alertVoltage.show = true
                        alertVoltage.show = false
                        break;
                    case 9:
                        bmslvCurrentEntry.entryColor = "red"
                        bmslvCurrentEntry.entryColor = "white"
                        alertVoltage.show = true
                        alertVoltage.show = false
                        break;
                    default:
                    }
                }
            }
       }

   }














    // bottom-left section, displaying voltage-type sensor readings
    Rectangle {
        id: voltageUI; z:-1
        anchors {
            bottom: root.bottom
            top: topUI.bottom; topMargin: -(topUI.height -bridge.height)
            left: root.left
        }
        width: root.width *0.5
        height: root.height -bridge.height
        gradient: Gradient {
            GradientStop {position: 0.0; color: "#4d4d4d"}
            GradientStop {position: 1.0; color: "#3a3a39"}
        }

        CustomBorder {
            borderColor: "#b3b3b0"
            borderThickness: 3
            borderSpacing: 5
            rounded: true
        }

        // column for various entries
        Column {
            spacing: voltageUI.width *0.02
            width: voltageUI.width; height: root.height *0.4
            anchors {
                horizontalCenter: voltageUI.horizontalCenter
                verticalCenter: voltageUI.verticalCenter
                verticalCenterOffset: rpmDial.height *0.2
            }

            SensorEntry {
                id: bmshvVoltageEntry; entryName: "BMSHV"; entryUnit: "V"
                from: 350; to: 460

                Connections {
                    target: dataSource
                    onBmshvVoltageRead: bmshvVoltageEntry.value = sensorValue
                }
            }

            SensorEntry {
                id: bmslvVoltageEntry; entryName: "BMSLV"; entryUnit: "V"
                from: 12; to: 18

                Connections {
                    target: dataSource
                    onBmslvVoltageRead: bmslvVoltageEntry.value = sensorValue
                }
            }

            SensorEntry {
                id: bmslvCurrentEntry; entryName: "BMSLV"; entryUnit: "A"
                from: 0; to: 30

                Connections {
                    target: dataSource
                    onBmslvCurrentRead: bmslvCurrentEntry.value = sensorValue
                }
            }

        }
    }














    // bottom-right section, displaying temperature-type sensor readings
    Rectangle {
        id: thermalsUI; z: -1
        anchors {
            bottom: root.bottom
            top: topUI.bottom; topMargin: -(topUI.height -bridge.height)
            left: voltageUI.right
            right: root.right
        }
        width: root.width *0.5
        height: root.height -bridge.height
        gradient: Gradient {
            GradientStop {position: 0.0; color: "#4d4d4d"}
            GradientStop {position: 1.0; color: "#3a3a39"}
        }

        CustomBorder {
            borderColor: "#b3b3b0"
            borderThickness: 3
            borderSpacing: 5
            rounded: true
        }

        // column for various entries
        Column {
            spacing: thermalsUI.width *0.02
            width: thermalsUI.width; height: root.height *0.4
            anchors {
                horizontalCenter: thermalsUI.horizontalCenter
                verticalCenter: thermalsUI.verticalCenter
                verticalCenterOffset: rpmDial.height *0.2
            }

            SensorEntry {
                id: bmshvTemperatureEntry; entryName: "BMSHV"; entryUnit: "°C"
                from: 20; to: 40

                Connections {
                    target: dataSource
                    onBmshvTempRead: bmshvTemperatureEntry.value = sensorValue
                }
            }

            SensorEntry {
                id: bmslvTemperatureEntry; entryName: "BMSLV"; entryUnit: "°C"
                from: 20; to: 50

                Connections {
                    target: dataSource
                    onBmslvTempRead: bmslvTemperatureEntry.value = sensorValue
                }
            }

            SensorEntry {
                id: inverterTemperatureEntry; entryName: "INVRT"; entryUnit: "°C"
                from: 20; to: 70

                Connections {
                    target: dataSource
                    onInverterTempRead: inverterTemperatureEntry.value = sensorValue
                }
            }

            SensorEntry {
                id: motorTemperatureEntry; entryName: "MOTOR"; entryUnit: "°C"
                from: 20; to: 80

                Connections {
                    target: dataSource
                    onMototrTempRead: motorTemperatureEntry.value = sensorValue
                }
            }
        }
    }
}
