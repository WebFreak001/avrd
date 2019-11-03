#!/bin/bash

FUSE="$(avr-objdump -s -j .fuse blinking.elf | grep 820000 | awk '{print $2}')"

if [ -z "$FUSE" ]; then
	echo "No fuse section in elf file"
	exit 1
fi

LO="$(echo -n $FUSE | cut -c1-2)"
HI="$(echo -n $FUSE | cut -c3-4)"
EX="$(echo -n $FUSE | cut -c5-6)"

echo "$LO"
echo "$HI"
echo "$EX"

ssh webfreak@192.168.178.57 "avrdude -p ATmega1284P -c stk500 -P /dev/ttyACM0 -B 115.2kHz \
	-U lfuse:w:0x$LO:m -U hfuse:w:0x$HI:m -U efuse:w:0x$EX:m"
