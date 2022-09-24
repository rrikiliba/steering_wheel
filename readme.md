# Recruiting steering wheel
project by: Riccardo Libanora
https://github.com/rrikiliba

## Version 0.1: Groundworks

- Basic UI layout
  - Feedback arranged according to type (thermals, voltage)

- First implementation of signals/slots system
  - Currently all simulated data gets funneled to a single text
  - System for redirection to different UI elements already in place

- Dedicated critical sensor read signal
  - Intended for changing specific properties of QML components (ie text turning red)

- Better organized project structure
  - Separating backend/frontend, utility files etc
