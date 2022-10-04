# Recruiting steering wheel
project by: [Riccardo Libanora](https://github.com/rrikiliba)

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

![image](https://user-images.githubusercontent.com/113705896/193797342-fe2f5279-7f68-4312-9643-3759b37420d2.png)
