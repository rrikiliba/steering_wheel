#ifndef BACKEND_H
#define BACKEND_H

#include <QObject>
#include <QString>
#include <qqml.h>
#include "data.hpp"
#include <iostream> //for debugging reasons

class BackEnd : public QObject {
    Q_OBJECT
public:
    explicit BackEnd(QObject *parent = nullptr){
          QObject::connect(new Data(parent), &Data::dataReceived, this, &BackEnd::ingestData);
    }

public slots:
    void ingestData(Data::Sensor sensor, float data){
        float lBound=0, uBound=0;
        switch(sensor){
        case Data::RPM:
            lBound=0;
            uBound=15000;
            emit rpmRead(data);
            break;
        case Data::SPEED:
            lBound=0;
            uBound=200;
            emit speedRead(data);
            break;
        case Data::POWER_LIMITER:
            lBound=0;
            uBound=100;
            emit limiterRead(data);
            break;
        case Data::BMS_HV_TEMP:
            lBound=20;
            uBound=40;
            emit bmshvTempRead(data);
            break;
        case Data::BMS_LV_TEMP:
            lBound=20;
            uBound=50;
            emit bmslvTempRead(data);
            break;
        case Data::INVERTER_TEMP:
            lBound=20;
            uBound=70;
            emit inverterTempRead(data);
            break;
        case Data::MOTOR_TEMP:
            lBound=20;
            uBound=80;
            emit mototrTempRead(data);
            break;
        case Data::BMS_HV_VOLTAGE:
            lBound=350;
            uBound=460;
            emit bmshvVoltageRead(data);
            break;
        case Data::BMS_LV_VOLTAGE:
            lBound=12;
            uBound=18;
            emit bmslvVoltageRead(data);
            break;
        case Data::BMS_LV_CURRENT:
            lBound=0;
            uBound=30;
            emit bmslvCurrentRead(data);
            break;
        default: return;
        }

        emit valueChanged(data);
        if(data<=lBound||data>=uBound){
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
