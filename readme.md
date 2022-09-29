# Recruiting steering wheel
project by: Riccardo Libanora
(https://github.com/rrikiliba)

## Version 0.6: actually usable?

- UI revision
  - Sligthly rearranged panels to better fit the windo
  - Better color choice and decoration

- Added entries for each sensor type
  - Each entry includes ID, numeric data and a progress bar

- Added feedback for critical data read
  - Display on top dedicated to signaling type of critical data read
  - Flashing UI elements for quick acknowledgement

- Fairly needed code cleanup


## Version 0.2: Top UI

- Simulated analog dials for speed and rpm
  - Numeric value still shown

- Limiter percentage displayer
  - Border color changing for quick reference of value

- Devided data-read signals according to source sensor
  - Rather than one signal being sent to every single component

- Some code cleanup


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
