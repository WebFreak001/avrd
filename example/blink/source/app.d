import avr.io;

import avr.util.delay;

// this example assumes you wired 8 LEDs to PB0:PB7
// adjust values to your actual setup

// Port registers for LED access
alias LED_DDR = DDRB;
alias LED_PORT = PORTB;

alias Delay = FrequencyDelay!(1 * MHz);

extern (C) void main()
{
	// set Data Direction Register to output for all 8 bits
	// change only the bits you have LEDs on
	LED_DDR = 0xFF;

	while (true)
	{
		// set all 8 LEDs to on
		LED_PORT = 0xFF;

		// or alternatively turn of all LEDs, except for the 3rd one
		//LED_PORT = (1 << 2);

		Delay.delayMsecs!(1000);

		// turn all LEDs off again
		LED_PORT = 0;

		Delay.delayMsecs!(1000);
	}
}
