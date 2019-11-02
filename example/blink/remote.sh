#!/bin/bash

# flash over SSH on a device connected with your microcontroller
# (in case your PC's USB controller doesn't support your programmer but you have a device which does)
# warning: this doesn't verify the memory which is written, which might cause issues
# calls `acpi` at the end to print battery status of device (e.g. on laptops)
ssh webfreak@192.168.178.57 "avrdude -p ATmega1284P -c stk500 -P /dev/ttyACM0 -B 115.2kHz -V -U flash:w:-:i ; acpi" < blinking.hex
