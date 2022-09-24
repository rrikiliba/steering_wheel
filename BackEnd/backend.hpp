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
            break;
        case Data::SPEED:
            lBound=0;
            uBound=200;
            break;
        case Data::POWER_LIMITER:
            lBound=0;
            uBound=100;
            break;
        case Data::BMS_HV_TEMP:
            lBound=20;
            uBound=40;
            break;
        case Data::BMS_LV_TEMP:
            lBound=20;
            uBound=50;
            break;
        case Data::INVERTER_TEMP:
            lBound=20;
            uBound=70;
            break;
        case Data::MOTOR_TEMP:
            lBound=20;
            uBound=80;
            break;
        case Data::BMS_HV_VOLTAGE:
            lBound=350;
            uBound=460;
            break;
        case Data::BMS_LV_VOLTAGE:
            lBound=12;
            uBound=18;
            break;
        case Data::BMS_LV_CURRENT:
            lBound=0;
            uBound=30;
            break;
        default: return;
        }
        emit valueChanged(data, static_cast<int>(sensor));
        std::cout<<data<<"\tfrom sensor:\t"<<sensor<<std::endl;
        if(data<=lBound||data>=uBound){
            emit valueCritical(static_cast<int>(sensor));
            std::cout<<"CRITICAL!\n";
        }
  }


signals:
    void valueChanged(float value, int sensor);
    void valueCritical(int sensor);
};

#endif
