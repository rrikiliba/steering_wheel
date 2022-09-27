#ifndef DATA_H
#define DATA_H

#include <QObject>
#include <QTimer>
#include <QDebug>
#include <QRandomGenerator>
#include <QMetaEnum>

class Data: public QObject {
    Q_OBJECT
public:
  enum Sensor {
    RPM,
    SPEED,
    POWER_LIMITER,
    BMS_HV_TEMP,
    BMS_LV_TEMP,
    INVERTER_TEMP,
    MOTOR_TEMP,
    BMS_HV_VOLTAGE,
    BMS_LV_VOLTAGE,
    BMS_LV_CURRENT,
    _SENSOR_SIZE
  };
  Q_ENUM(Sensor)

  Data(QObject *parent = nullptr) : QObject(parent) {
    // get a QTimer object to set off every second and start it immediatly
    _clock = new QTimer();
    _clock->setInterval(500);
    _clock->start();
    // bind the signal of timeout from the timer to the generateData() function
    connect(_clock, &QTimer::timeout, this, &Data::generateData);
  }

  ~Data() {
    delete _clock;
  }

private slots:
  void generateData() {
    // generate a value between 0 and the _SENSOR_SIZE (number of sensors)
    Sensor sensor = static_cast<Sensor>(QRandomGenerator::global()->generate() % Sensor::_SENSOR_SIZE);
    switch (sensor) {
      // based on the result, send signal from different sensor
      case RPM: emit dataReceived(sensor, QRandomGenerator::global()->bounded(15000.0f)); return;
      case SPEED: emit dataReceived(sensor, QRandomGenerator::global()->bounded(120.0f)); return;
      case POWER_LIMITER: emit dataReceived(sensor, QRandomGenerator::global()->bounded(5) * 0.2f); return;
      case BMS_HV_TEMP: emit dataReceived(sensor, QRandomGenerator::global()->bounded(60.0f)); return;
      case BMS_LV_TEMP: emit dataReceived(sensor, QRandomGenerator::global()->bounded(70.0f)); return;
      case INVERTER_TEMP: emit dataReceived(sensor, QRandomGenerator::global()->bounded(90.0f)); return;
      case MOTOR_TEMP: emit dataReceived(sensor, QRandomGenerator::global()->bounded(110.0f)); return;
      case BMS_HV_VOLTAGE: emit dataReceived(sensor, 350.0f + QRandomGenerator::global()->bounded(110.0f)); return;
      case BMS_LV_VOLTAGE: emit dataReceived(sensor, 12.0f + QRandomGenerator::global()->bounded(6.0f)); return;
      case BMS_LV_CURRENT: emit dataReceived(sensor, QRandomGenerator::global()->bounded(30.0f)); return;
      default: return;
    }
  };

signals:
  void dataReceived(Data::Sensor sensor, float data);

private:
  QTimer *_clock;
};

#endif // DATA_H
