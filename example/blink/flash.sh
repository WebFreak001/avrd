#!/bin/bash

avrdude -p ATmega1284P -c stk500 -P /dev/ttyACM0 -B 115.2kHz -U flash:w:blinking.hex:i
