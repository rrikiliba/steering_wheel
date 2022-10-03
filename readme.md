# Recruiting steering wheel
project by: Riccardo Libanora
(https://github.com/rrikiliba)

## Version 1.0: final release

### Quick sumup of features

- Main part of the UI includes two dials, for speed and RPM, limiter percentage, as well as a display for critical values (more on that later)
  - Both dials and limiter display colors corresponding to value (as in, red==low, green==high)

- Bottom-left section is dedicated to voltages of BMSHV and BMSLV, and current of BMSLV
- Bottom right displays temperatures of the same components, as well as motor and inverter
  - All the entries in the bottom part include a progress bar, from critical low to critical high 

- When data is determined to be critical:
  - The display on top will show a signal with a symbol corresponding to the sensor type, on the left or right depending, again, on type
  - The correspomding progress bar will be empty if the value is too low, or flashing red if the value is too high

- Fairly simple backend: the data generator is hooked to the BackEnd class, which takes the dataReceived(..) signal and determines the correct signals to send as well as if it's between safe bounds (via a simple switch statement)
  - The purpose behind this is that every QML component will receive its own signal, rather than listening to a generic signal and then having to determine whether it was meant for it
  - The point above is not applied to the signal valueCritical(.), as it won't be active as often and will be managed and sorted by the critical display in the front end


## Version 0.6: actually usable?

- UI revision
  - Sligthly rearranged panels to better fit the windo
  - Better color choice and decoration

- Added entries for each sensor type
  - Each entry includes ID, numeric data and a progress bar

- Added feedback for critical data read
  - Display on top dedicated to signaling type of critical data read
  - Flashing UI elements for quick acknowledgement

- Some needed code cleanup


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
