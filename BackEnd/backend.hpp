#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QString>
#include <qqml.h>
#include "data.hpp"

class BackEnd : public QObject {
    Q_OBJECT
public:
    explicit BackEnd(Data &dataSource){
          QObject::connect(&dataSource, &Data::dataReceived, this, &BackEnd::ingestData);
    }

public slots:
    void ingestData(Data::Sensor sensor, float data){
        float from=0, to=0;
        switch(sensor){
        case Data::RPM:
            from=0;
            to=15000;
            emit rpmRead(data);
            break;
        case Data::SPEED:
            from=0;
            to=200;
            emit speedRead(data);
            break;
        case Data::POWER_LIMITER:
            from=0;
            to=100;
            emit limiterRead(data);
            break;
        case Data::BMS_HV_TEMP:
            from=20;
            to=40;
            emit bmshvTempRead(data);
            break;
        case Data::BMS_LV_TEMP:
            from=20;
            to=50;
            emit bmslvTempRead(data);
            break;
        case Data::INVERTER_TEMP:
            from=20;
            to=70;
            emit inverterTempRead(data);
            break;
        case Data::MOTOR_TEMP:
            from=20;
            to=80;
            emit mototrTempRead(data);
            break;
        case Data::BMS_HV_VOLTAGE:
            from=350;
            to=460;
            emit bmshvVoltageRead(data);
            break;
        case Data::BMS_LV_VOLTAGE:
            from=12;
            to=18;
            emit bmslvVoltageRead(data);
            break;
        case Data::BMS_LV_CURRENT:
            from=0;
            to=30;
            emit bmslvCurrentRead(data);
            break;
        default: return;
        }

        emit valueChanged(data);
        if(data<=from||data>=to){
            emit valueCritical(static_cast<int>(sensor));

        }
  }


signals:
    void valueChanged(float sensorValue);
    void valueCritical(int sensorID);

    void rpmRead(float sensorValue);
    void speedRead(float sensorValue);
    void limiterRead(float sensorValue);
    void bmshvTempRead(float sensorValue);
    void bmslvTempRead(float sensorValue);
    void inverterTempRead(float sensorValue);
    void mototrTempRead(float sensorValue);
    void bmshvVoltageRead(float sensorValue);
    void bmslvVoltageRead(float sensorValue);
    void bmslvCurrentRead(float sensorValue);
};

#endif
