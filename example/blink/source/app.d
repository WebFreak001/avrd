import avr.io;

// this example assumes you wired 8 LEDs to PB0:PB7
// adjust values to your actual setup

// Port registers for LED access
alias LED_DDR = DDRB;
alias LED_PORT = PORTB;

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
	}
}
