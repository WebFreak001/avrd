module avr.device.io_m328p;

/* Copyright (c) 2007 Atmel Corporation
   All rights reserved.

   Redistribution and use in source and binary forms, with or without
   modification, are permitted provided that the following conditions are met:

   * Redistributions of source code must retain the above copyright
     notice, this list of conditions and the following disclaimer.

   * Redistributions in binary form must reproduce the above copyright
     notice, this list of conditions and the following disclaimer in
     the documentation and/or other materials provided with the
     distribution.

   * Neither the name of the copyright holders nor the names of
     contributors may be used to endorse or promote products derived
     from this software without specific prior written permission.

  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
  POSSIBILITY OF SUCH DAMAGE. 
*/

/* $Id: iom328p.h 2460 2014-12-03 05:39:25Z pitchumani $ */

/* avr/iom328p.h - definitions for ATmega328P. */

/* This file should only be included from <avr/io.h>, never directly. */

import avr.sfr_defs;

/* Registers and associated bit numbers */

enum PINB = _SFR_IO8!0x03;
enum PINB0 = 0;
enum PINB1 = 1;
enum PINB2 = 2;
enum PINB3 = 3;
enum PINB4 = 4;
enum PINB5 = 5;
enum PINB6 = 6;
enum PINB7 = 7;

enum DDRB = _SFR_IO8!0x04;
enum DDB0 = 0;
enum DDB1 = 1;
enum DDB2 = 2;
enum DDB3 = 3;
enum DDB4 = 4;
enum DDB5 = 5;
enum DDB6 = 6;
enum DDB7 = 7;

enum PORTB = _SFR_IO8!0x05;
enum PORTB0 = 0;
enum PORTB1 = 1;
enum PORTB2 = 2;
enum PORTB3 = 3;
enum PORTB4 = 4;
enum PORTB5 = 5;
enum PORTB6 = 6;
enum PORTB7 = 7;

enum PINC = _SFR_IO8!0x06;
enum PINC0 = 0;
enum PINC1 = 1;
enum PINC2 = 2;
enum PINC3 = 3;
enum PINC4 = 4;
enum PINC5 = 5;
enum PINC6 = 6;

enum DDRC = _SFR_IO8!0x07;
enum DDC0 = 0;
enum DDC1 = 1;
enum DDC2 = 2;
enum DDC3 = 3;
enum DDC4 = 4;
enum DDC5 = 5;
enum DDC6 = 6;

enum PORTC = _SFR_IO8!0x08;
enum PORTC0 = 0;
enum PORTC1 = 1;
enum PORTC2 = 2;
enum PORTC3 = 3;
enum PORTC4 = 4;
enum PORTC5 = 5;
enum PORTC6 = 6;

enum PIND = _SFR_IO8!0x09;
enum PIND0 = 0;
enum PIND1 = 1;
enum PIND2 = 2;
enum PIND3 = 3;
enum PIND4 = 4;
enum PIND5 = 5;
enum PIND6 = 6;
enum PIND7 = 7;

enum DDRD = _SFR_IO8!0x0A;
enum DDD0 = 0;
enum DDD1 = 1;
enum DDD2 = 2;
enum DDD3 = 3;
enum DDD4 = 4;
enum DDD5 = 5;
enum DDD6 = 6;
enum DDD7 = 7;

enum PORTD = _SFR_IO8!0x0B;
enum PORTD0 = 0;
enum PORTD1 = 1;
enum PORTD2 = 2;
enum PORTD3 = 3;
enum PORTD4 = 4;
enum PORTD5 = 5;
enum PORTD6 = 6;
enum PORTD7 = 7;

enum TIFR0 = _SFR_IO8!0x15;
enum TOV0 = 0;
enum OCF0A = 1;
enum OCF0B = 2;

enum TIFR1 = _SFR_IO8!0x16;
enum TOV1 = 0;
enum OCF1A = 1;
enum OCF1B = 2;
enum ICF1 = 5;

enum TIFR2 = _SFR_IO8!0x17;
enum TOV2 = 0;
enum OCF2A = 1;
enum OCF2B = 2;

enum PCIFR = _SFR_IO8!0x1B;
enum PCIF0 = 0;
enum PCIF1 = 1;
enum PCIF2 = 2;

enum EIFR = _SFR_IO8!0x1C;
enum INTF0 = 0;
enum INTF1 = 1;

enum EIMSK = _SFR_IO8!0x1D;
enum INT0 = 0;
enum INT1 = 1;

enum GPIOR0 = _SFR_IO8!0x1E;
enum GPIOR00 = 0;
enum GPIOR01 = 1;
enum GPIOR02 = 2;
enum GPIOR03 = 3;
enum GPIOR04 = 4;
enum GPIOR05 = 5;
enum GPIOR06 = 6;
enum GPIOR07 = 7;

enum EECR = _SFR_IO8!0x1F;
enum EERE = 0;
enum EEPE = 1;
enum EEMPE = 2;
enum EERIE = 3;
enum EEPM0 = 4;
enum EEPM1 = 5;

enum EEDR = _SFR_IO8!0x20;
enum EEDR0 = 0;
enum EEDR1 = 1;
enum EEDR2 = 2;
enum EEDR3 = 3;
enum EEDR4 = 4;
enum EEDR5 = 5;
enum EEDR6 = 6;
enum EEDR7 = 7;

enum EEAR = _SFR_IO16!0x21;

enum EEARL = _SFR_IO8!0x21;
enum EEAR0 = 0;
enum EEAR1 = 1;
enum EEAR2 = 2;
enum EEAR3 = 3;
enum EEAR4 = 4;
enum EEAR5 = 5;
enum EEAR6 = 6;
enum EEAR7 = 7;

enum EEARH = _SFR_IO8!0x22;
enum EEAR8 = 0;
enum EEAR9 = 1;

enum _EEPROM_REG_LOCATIONS_ = 0x1F2021;

enum GTCCR = _SFR_IO8!0x23;
enum PSRSYNC = 0;
enum PSRASY = 1;
enum TSM = 7;

enum TCCR0A = _SFR_IO8!0x24;
enum WGM00 = 0;
enum WGM01 = 1;
enum COM0B0 = 4;
enum COM0B1 = 5;
enum COM0A0 = 6;
enum COM0A1 = 7;

enum TCCR0B = _SFR_IO8!0x25;
enum CS00 = 0;
enum CS01 = 1;
enum CS02 = 2;
enum WGM02 = 3;
enum FOC0B = 6;
enum FOC0A = 7;

enum TCNT0 = _SFR_IO8!0x26;
enum TCNT0_0 = 0;
enum TCNT0_1 = 1;
enum TCNT0_2 = 2;
enum TCNT0_3 = 3;
enum TCNT0_4 = 4;
enum TCNT0_5 = 5;
enum TCNT0_6 = 6;
enum TCNT0_7 = 7;

enum OCR0A = _SFR_IO8!0x27;
enum OCR0A_0 = 0;
enum OCR0A_1 = 1;
enum OCR0A_2 = 2;
enum OCR0A_3 = 3;
enum OCR0A_4 = 4;
enum OCR0A_5 = 5;
enum OCR0A_6 = 6;
enum OCR0A_7 = 7;

enum OCR0B = _SFR_IO8!0x28;
enum OCR0B_0 = 0;
enum OCR0B_1 = 1;
enum OCR0B_2 = 2;
enum OCR0B_3 = 3;
enum OCR0B_4 = 4;
enum OCR0B_5 = 5;
enum OCR0B_6 = 6;
enum OCR0B_7 = 7;

enum GPIOR1 = _SFR_IO8!0x2A;
enum GPIOR10 = 0;
enum GPIOR11 = 1;
enum GPIOR12 = 2;
enum GPIOR13 = 3;
enum GPIOR14 = 4;
enum GPIOR15 = 5;
enum GPIOR16 = 6;
enum GPIOR17 = 7;

enum GPIOR2 = _SFR_IO8!0x2B;
enum GPIOR20 = 0;
enum GPIOR21 = 1;
enum GPIOR22 = 2;
enum GPIOR23 = 3;
enum GPIOR24 = 4;
enum GPIOR25 = 5;
enum GPIOR26 = 6;
enum GPIOR27 = 7;

enum SPCR = _SFR_IO8!0x2C;
enum SPR0 = 0;
enum SPR1 = 1;
enum CPHA = 2;
enum CPOL = 3;
enum MSTR = 4;
enum DORD = 5;
enum SPE = 6;
enum SPIE = 7;

enum SPSR = _SFR_IO8!0x2D;
enum SPI2X = 0;
enum WCOL = 6;
enum SPIF = 7;

enum SPDR = _SFR_IO8!0x2E;
enum SPDR0 = 0;
enum SPDR1 = 1;
enum SPDR2 = 2;
enum SPDR3 = 3;
enum SPDR4 = 4;
enum SPDR5 = 5;
enum SPDR6 = 6;
enum SPDR7 = 7;

enum ACSR = _SFR_IO8!0x30;
enum ACIS0 = 0;
enum ACIS1 = 1;
enum ACIC = 2;
enum ACIE = 3;
enum ACI = 4;
enum ACO = 5;
enum ACBG = 6;
enum ACD = 7;

enum SMCR = _SFR_IO8!0x33;
enum SE = 0;
enum SM0 = 1;
enum SM1 = 2;
enum SM2 = 3;

enum MCUSR = _SFR_IO8!0x34;
enum PORF = 0;
enum EXTRF = 1;
enum BORF = 2;
enum WDRF = 3;

enum MCUCR = _SFR_IO8!0x35;
enum IVCE = 0;
enum IVSEL = 1;
enum PUD = 4;
enum BODSE = 5;
enum BODS = 6;

enum SPMCSR = _SFR_IO8!0x37;
enum SPMEN = 0;
enum PGERS = 1;
enum PGWRT = 2;
enum BLBSET = 3;
enum RWWSRE = 4;
enum SIGRD = 5;
enum RWWSB = 6;
enum SPMIE = 7;

enum WDTCSR = _SFR_MEM8!0x60;
enum WDP0 = 0;
enum WDP1 = 1;
enum WDP2 = 2;
enum WDE = 3;
enum WDCE = 4;
enum WDP3 = 5;
enum WDIE = 6;
enum WDIF = 7;

enum CLKPR = _SFR_MEM8!0x61;
enum CLKPS0 = 0;
enum CLKPS1 = 1;
enum CLKPS2 = 2;
enum CLKPS3 = 3;
enum CLKPCE = 7;

enum PRR = _SFR_MEM8!0x64;
enum PRADC = 0;
enum PRUSART0 = 1;
enum PRSPI = 2;
enum PRTIM1 = 3;
enum PRTIM0 = 5;
enum PRTIM2 = 6;
enum PRTWI = 7;

enum __AVR_HAVE_PRR = ((1 << PRADC) | (1 << PRUSART0) | (1 << PRSPI) | (
      1 << PRTIM1) | (1 << PRTIM0) | (1 << PRTIM2) | (1 << PRTWI));
enum __AVR_HAVE_PRR_PRADC = true;
enum __AVR_HAVE_PRR_PRUSART0 = true;
enum __AVR_HAVE_PRR_PRSPI = true;
enum __AVR_HAVE_PRR_PRTIM1 = true;
enum __AVR_HAVE_PRR_PRTIM0 = true;
enum __AVR_HAVE_PRR_PRTIM2 = true;
enum __AVR_HAVE_PRR_PRTWI = true;

enum OSCCAL = _SFR_MEM8!0x66;
enum CAL0 = 0;
enum CAL1 = 1;
enum CAL2 = 2;
enum CAL3 = 3;
enum CAL4 = 4;
enum CAL5 = 5;
enum CAL6 = 6;
enum CAL7 = 7;

enum PCICR = _SFR_MEM8!0x68;
enum PCIE0 = 0;
enum PCIE1 = 1;
enum PCIE2 = 2;

enum EICRA = _SFR_MEM8!0x69;
enum ISC00 = 0;
enum ISC01 = 1;
enum ISC10 = 2;
enum ISC11 = 3;

enum PCMSK0 = _SFR_MEM8!0x6B;
enum PCINT0 = 0;
enum PCINT1 = 1;
enum PCINT2 = 2;
enum PCINT3 = 3;
enum PCINT4 = 4;
enum PCINT5 = 5;
enum PCINT6 = 6;
enum PCINT7 = 7;

enum PCMSK1 = _SFR_MEM8!0x6C;
enum PCINT8 = 0;
enum PCINT9 = 1;
enum PCINT10 = 2;
enum PCINT11 = 3;
enum PCINT12 = 4;
enum PCINT13 = 5;
enum PCINT14 = 6;

enum PCMSK2 = _SFR_MEM8!0x6D;
enum PCINT16 = 0;
enum PCINT17 = 1;
enum PCINT18 = 2;
enum PCINT19 = 3;
enum PCINT20 = 4;
enum PCINT21 = 5;
enum PCINT22 = 6;
enum PCINT23 = 7;

enum TIMSK0 = _SFR_MEM8!0x6E;
enum TOIE0 = 0;
enum OCIE0A = 1;
enum OCIE0B = 2;

enum TIMSK1 = _SFR_MEM8!0x6F;
enum TOIE1 = 0;
enum OCIE1A = 1;
enum OCIE1B = 2;
enum ICIE1 = 5;

enum TIMSK2 = _SFR_MEM8!0x70;
enum TOIE2 = 0;
enum OCIE2A = 1;
enum OCIE2B = 2;

version (__ASSEMBLER__)
{
}
else
{
  enum ADC = _SFR_MEM16!0x78;
}
enum ADCW = _SFR_MEM16!0x78;

enum ADCL = _SFR_MEM8!0x78;
enum ADCL0 = 0;
enum ADCL1 = 1;
enum ADCL2 = 2;
enum ADCL3 = 3;
enum ADCL4 = 4;
enum ADCL5 = 5;
enum ADCL6 = 6;
enum ADCL7 = 7;

enum ADCH = _SFR_MEM8!0x79;
enum ADCH0 = 0;
enum ADCH1 = 1;
enum ADCH2 = 2;
enum ADCH3 = 3;
enum ADCH4 = 4;
enum ADCH5 = 5;
enum ADCH6 = 6;
enum ADCH7 = 7;

enum ADCSRA = _SFR_MEM8!0x7A;
enum ADPS0 = 0;
enum ADPS1 = 1;
enum ADPS2 = 2;
enum ADIE = 3;
enum ADIF = 4;
enum ADATE = 5;
enum ADSC = 6;
enum ADEN = 7;

enum ADCSRB = _SFR_MEM8!0x7B;
enum ADTS0 = 0;
enum ADTS1 = 1;
enum ADTS2 = 2;
enum ACME = 6;

enum ADMUX = _SFR_MEM8!0x7C;
enum MUX0 = 0;
enum MUX1 = 1;
enum MUX2 = 2;
enum MUX3 = 3;
enum ADLAR = 5;
enum REFS0 = 6;
enum REFS1 = 7;

enum DIDR0 = _SFR_MEM8!0x7E;
enum ADC0D = 0;
enum ADC1D = 1;
enum ADC2D = 2;
enum ADC3D = 3;
enum ADC4D = 4;
enum ADC5D = 5;

enum DIDR1 = _SFR_MEM8!0x7F;
enum AIN0D = 0;
enum AIN1D = 1;

enum TCCR1A = _SFR_MEM8!0x80;
enum WGM10 = 0;
enum WGM11 = 1;
enum COM1B0 = 4;
enum COM1B1 = 5;
enum COM1A0 = 6;
enum COM1A1 = 7;

enum TCCR1B = _SFR_MEM8!0x81;
enum CS10 = 0;
enum CS11 = 1;
enum CS12 = 2;
enum WGM12 = 3;
enum WGM13 = 4;
enum ICES1 = 6;
enum ICNC1 = 7;

enum TCCR1C = _SFR_MEM8!0x82;
enum FOC1B = 6;
enum FOC1A = 7;

enum TCNT1 = _SFR_MEM16!0x84;

enum TCNT1L = _SFR_MEM8!0x84;
enum TCNT1L0 = 0;
enum TCNT1L1 = 1;
enum TCNT1L2 = 2;
enum TCNT1L3 = 3;
enum TCNT1L4 = 4;
enum TCNT1L5 = 5;
enum TCNT1L6 = 6;
enum TCNT1L7 = 7;

enum TCNT1H = _SFR_MEM8!0x85;
enum TCNT1H0 = 0;
enum TCNT1H1 = 1;
enum TCNT1H2 = 2;
enum TCNT1H3 = 3;
enum TCNT1H4 = 4;
enum TCNT1H5 = 5;
enum TCNT1H6 = 6;
enum TCNT1H7 = 7;

enum ICR1 = _SFR_MEM16!0x86;

enum ICR1L = _SFR_MEM8!0x86;
enum ICR1L0 = 0;
enum ICR1L1 = 1;
enum ICR1L2 = 2;
enum ICR1L3 = 3;
enum ICR1L4 = 4;
enum ICR1L5 = 5;
enum ICR1L6 = 6;
enum ICR1L7 = 7;

enum ICR1H = _SFR_MEM8!0x87;
enum ICR1H0 = 0;
enum ICR1H1 = 1;
enum ICR1H2 = 2;
enum ICR1H3 = 3;
enum ICR1H4 = 4;
enum ICR1H5 = 5;
enum ICR1H6 = 6;
enum ICR1H7 = 7;

enum OCR1A = _SFR_MEM16!0x88;

enum OCR1AL = _SFR_MEM8!0x88;
enum OCR1AL0 = 0;
enum OCR1AL1 = 1;
enum OCR1AL2 = 2;
enum OCR1AL3 = 3;
enum OCR1AL4 = 4;
enum OCR1AL5 = 5;
enum OCR1AL6 = 6;
enum OCR1AL7 = 7;

enum OCR1AH = _SFR_MEM8!0x89;
enum OCR1AH0 = 0;
enum OCR1AH1 = 1;
enum OCR1AH2 = 2;
enum OCR1AH3 = 3;
enum OCR1AH4 = 4;
enum OCR1AH5 = 5;
enum OCR1AH6 = 6;
enum OCR1AH7 = 7;

enum OCR1B = _SFR_MEM16!0x8A;

enum OCR1BL = _SFR_MEM8!0x8A;
enum OCR1BL0 = 0;
enum OCR1BL1 = 1;
enum OCR1BL2 = 2;
enum OCR1BL3 = 3;
enum OCR1BL4 = 4;
enum OCR1BL5 = 5;
enum OCR1BL6 = 6;
enum OCR1BL7 = 7;

enum OCR1BH = _SFR_MEM8!0x8B;
enum OCR1BH0 = 0;
enum OCR1BH1 = 1;
enum OCR1BH2 = 2;
enum OCR1BH3 = 3;
enum OCR1BH4 = 4;
enum OCR1BH5 = 5;
enum OCR1BH6 = 6;
enum OCR1BH7 = 7;

enum TCCR2A = _SFR_MEM8!0xB0;
enum WGM20 = 0;
enum WGM21 = 1;
enum COM2B0 = 4;
enum COM2B1 = 5;
enum COM2A0 = 6;
enum COM2A1 = 7;

enum TCCR2B = _SFR_MEM8!0xB1;
enum CS20 = 0;
enum CS21 = 1;
enum CS22 = 2;
enum WGM22 = 3;
enum FOC2B = 6;
enum FOC2A = 7;

enum TCNT2 = _SFR_MEM8!0xB2;
enum TCNT2_0 = 0;
enum TCNT2_1 = 1;
enum TCNT2_2 = 2;
enum TCNT2_3 = 3;
enum TCNT2_4 = 4;
enum TCNT2_5 = 5;
enum TCNT2_6 = 6;
enum TCNT2_7 = 7;

enum OCR2A = _SFR_MEM8!0xB3;
enum OCR2A_0 = 0;
enum OCR2A_1 = 1;
enum OCR2A_2 = 2;
enum OCR2A_3 = 3;
enum OCR2A_4 = 4;
enum OCR2A_5 = 5;
enum OCR2A_6 = 6;
enum OCR2A_7 = 7;

enum OCR2B = _SFR_MEM8!0xB4;
enum OCR2B_0 = 0;
enum OCR2B_1 = 1;
enum OCR2B_2 = 2;
enum OCR2B_3 = 3;
enum OCR2B_4 = 4;
enum OCR2B_5 = 5;
enum OCR2B_6 = 6;
enum OCR2B_7 = 7;

enum ASSR = _SFR_MEM8!0xB6;
enum TCR2BUB = 0;
enum TCR2AUB = 1;
enum OCR2BUB = 2;
enum OCR2AUB = 3;
enum TCN2UB = 4;
enum AS2 = 5;
enum EXCLK = 6;

enum TWBR = _SFR_MEM8!0xB8;
enum TWBR0 = 0;
enum TWBR1 = 1;
enum TWBR2 = 2;
enum TWBR3 = 3;
enum TWBR4 = 4;
enum TWBR5 = 5;
enum TWBR6 = 6;
enum TWBR7 = 7;

enum TWSR = _SFR_MEM8!0xB9;
enum TWPS0 = 0;
enum TWPS1 = 1;
enum TWS3 = 3;
enum TWS4 = 4;
enum TWS5 = 5;
enum TWS6 = 6;
enum TWS7 = 7;

enum TWAR = _SFR_MEM8!0xBA;
enum TWGCE = 0;
enum TWA0 = 1;
enum TWA1 = 2;
enum TWA2 = 3;
enum TWA3 = 4;
enum TWA4 = 5;
enum TWA5 = 6;
enum TWA6 = 7;

enum TWDR = _SFR_MEM8!0xBB;
enum TWD0 = 0;
enum TWD1 = 1;
enum TWD2 = 2;
enum TWD3 = 3;
enum TWD4 = 4;
enum TWD5 = 5;
enum TWD6 = 6;
enum TWD7 = 7;

enum TWCR = _SFR_MEM8!0xBC;
enum TWIE = 0;
enum TWEN = 2;
enum TWWC = 3;
enum TWSTO = 4;
enum TWSTA = 5;
enum TWEA = 6;
enum TWINT = 7;

enum TWAMR = _SFR_MEM8!0xBD;
enum TWAM0 = 0;
enum TWAM1 = 1;
enum TWAM2 = 2;
enum TWAM3 = 3;
enum TWAM4 = 4;
enum TWAM5 = 5;
enum TWAM6 = 6;

enum UCSR0A = _SFR_MEM8!0xC0;
enum MPCM0 = 0;
enum U2X0 = 1;
enum UPE0 = 2;
enum DOR0 = 3;
enum FE0 = 4;
enum UDRE0 = 5;
enum TXC0 = 6;
enum RXC0 = 7;

enum UCSR0B = _SFR_MEM8!0xC1;
enum TXB80 = 0;
enum RXB80 = 1;
enum UCSZ02 = 2;
enum TXEN0 = 3;
enum RXEN0 = 4;
enum UDRIE0 = 5;
enum TXCIE0 = 6;
enum RXCIE0 = 7;

enum UCSR0C = _SFR_MEM8!0xC2;
enum UCPOL0 = 0;
enum UCSZ00 = 1;
enum UCPHA0 = 1;
enum UCSZ01 = 2;
enum UDORD0 = 2;
enum USBS0 = 3;
enum UPM00 = 4;
enum UPM01 = 5;
enum UMSEL00 = 6;
enum UMSEL01 = 7;

enum UBRR0 = _SFR_MEM16!0xC4;

enum UBRR0L = _SFR_MEM8!0xC4;
enum UBRR0_0 = 0;
enum UBRR0_1 = 1;
enum UBRR0_2 = 2;
enum UBRR0_3 = 3;
enum UBRR0_4 = 4;
enum UBRR0_5 = 5;
enum UBRR0_6 = 6;
enum UBRR0_7 = 7;

enum UBRR0H = _SFR_MEM8!0xC5;
enum UBRR0_8 = 0;
enum UBRR0_9 = 1;
enum UBRR0_10 = 2;
enum UBRR0_11 = 3;

enum UDR0 = _SFR_MEM8!0xC6;
enum UDR0_0 = 0;
enum UDR0_1 = 1;
enum UDR0_2 = 2;
enum UDR0_3 = 3;
enum UDR0_4 = 4;
enum UDR0_5 = 5;
enum UDR0_6 = 6;
enum UDR0_7 = 7;

/* Interrupt Vectors */
/* Interrupt Vector 0 is the reset vector. */

enum INT0_vect = 1; /// External Interrupt Request 0
enum INT1_vect = 2; /// External Interrupt Request 1
enum PCINT0_vect = 3; /// Pin Change Interrupt Request 0
enum PCINT1_vect = 4; /// Pin Change Interrupt Request 0
enum PCINT2_vect = 5; /// Pin Change Interrupt Request 1
enum WDT_vect = 6; /// Watchdog Time-out Interrupt
enum TIMER2_COMPA_vect = 7; /// Timer/Counter2 Compare Match A
enum TIMER2_COMPB_vect = 8; /// Timer/Counter2 Compare Match A
enum TIMER2_OVF_vect = 9; /// Timer/Counter2 Overflow
enum TIMER1_CAPT_vect = 10; /// Timer/Counter1 Capture Event
enum TIMER1_COMPA_vect = 11; /// Timer/Counter1 Compare Match A
enum TIMER1_COMPB_vect = 12; /// Timer/Counter1 Compare Match B 
enum TIMER1_OVF_vect = 13; /// Timer/Counter1 Overflow
enum TIMER0_COMPA_vect = 14; /// TimerCounter0 Compare Match A
enum TIMER0_COMPB_vect = 15; /// TimerCounter0 Compare Match B
enum TIMER0_OVF_vect = 16; /// Timer/Couner0 Overflow
enum SPI_STC_vect = 17; /// SPI Serial Transfer Complete
enum USART_RX_vect = 18; /// USART Rx Complete
enum USART_UDRE_vect = 19; /// USART, Data Register Empty
enum USART_TX_vect = 20; /// USART Tx Complete
enum ADC_vect = 21; /// ADC Conversion Complete
enum EE_READY_vect = 22; /// EEPROM Ready
enum ANALOG_COMP_vect = 23; /// Analog Comparator
enum TWI_vect = 24; /// Two-wire Serial Interface
enum SPM_READY_vect = 25; /// Store Program Memory Read
enum _VECTORS_SIZE = (26 * 4);

/* Constants */
enum SPM_PAGESIZE = 128;
enum RAMSTART = (0x100);
enum RAMEND = 0x8FF; /// Last On-Chip SRAM Location
enum XRAMSIZE = 0;
enum XRAMEND = RAMEND;
enum E2END = 0x3FF;
enum E2PAGESIZE = 4;
enum FLASHEND = 0x7FFF;

/* Fuses */
enum FUSE_MEMORY_SIZE = 3;

/* Low Fuse Byte */
enum FUSE_CKSEL0 = cast(ubyte)~_BV!0; /// Select Clock Source
enum FUSE_CKSEL1 = cast(ubyte)~_BV!1; /// Select Clock Source
enum FUSE_CKSEL2 = cast(ubyte)~_BV!2; /// Select Clock Source
enum FUSE_CKSEL3 = cast(ubyte)~_BV!3; /// Select Clock Source
enum FUSE_SUT0 = cast(ubyte)~_BV!4; /// Select start-up time
enum FUSE_SUT1 = cast(ubyte)~_BV!5; /// Select start-up time
enum FUSE_CKOUT = cast(ubyte)~_BV!6; /// Clock output
enum FUSE_CKDIV8 = cast(ubyte)~_BV!7; /// Divide clock by 8
enum LFUSE_DEFAULT = (FUSE_CKSEL0 & FUSE_CKSEL2 & FUSE_CKSEL3 & FUSE_SUT0 & FUSE_CKDIV8);

/* High Fuse Byte */
enum FUSE_BOOTRST = cast(ubyte)~_BV!0;
enum FUSE_BOOTSZ0 = cast(ubyte)~_BV!1;
enum FUSE_BOOTSZ1 = cast(ubyte)~_BV!2;
enum FUSE_EESAVE = cast(ubyte)~_BV!3; /// EEPROM memory is preserved through chip erase
enum FUSE_WDTON = cast(ubyte)~_BV!4; /// Watchdog Timer Always On
enum FUSE_SPIEN = cast(ubyte)~_BV!5; /// Enable Serial programming and Data Downloading
enum FUSE_DWEN = cast(ubyte)~_BV!6; /// debugWIRE Enable
enum FUSE_RSTDISBL = cast(ubyte)~_BV!7; /// External reset disable
enum HFUSE_DEFAULT = (FUSE_BOOTSZ0 & FUSE_BOOTSZ1 & FUSE_SPIEN);

/* Extended Fuse Byte */
enum FUSE_BODLEVEL0 = cast(ubyte)~_BV!0; /// Brown-out Detector trigger level
enum FUSE_BODLEVEL1 = cast(ubyte)~_BV!1; /// Brown-out Detector trigger level
enum FUSE_BODLEVEL2 = cast(ubyte)~_BV!2; /// Brown-out Detector trigger level
enum EFUSE_DEFAULT = (0xFF);

/* Lock Bits */
enum __LOCK_BITS_EXIST = true;
enum __BOOT_LOCK_BITS_0_EXIST = true;
enum __BOOT_LOCK_BITS_1_EXIST = true;

/* Signature */
enum SIGNATURE_0 = 0x1E;
enum SIGNATURE_1 = 0x95;
version (__AVR_ATmega328__)
{
  enum SIGNATURE_2 = 0x14;
}
else /* ATmega328P */
{
  enum SIGNATURE_2 = 0x0F;
}

enum SLEEP_MODE_IDLE = (0x00 << 1);
enum SLEEP_MODE_ADC = (0x01 << 1);
enum SLEEP_MODE_PWR_DOWN = (0x02 << 1);
enum SLEEP_MODE_PWR_SAVE = (0x03 << 1);
enum SLEEP_MODE_STANDBY = (0x06 << 1);
enum SLEEP_MODE_EXT_STANDBY = (0x07 << 1);
