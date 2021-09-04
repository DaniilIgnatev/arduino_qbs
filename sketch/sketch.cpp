/*
 * adc.cpp
 *
 * Created: 04.09.2021 19:03:02
 * Author : daniil
 */

#include <avr/io.h>


int main(void)
{
    DDRB = (uint8_t)0b11111111;
    PORTB = (uint8_t)0b00000000;

    ADMUX =  (uint8_t)0b11000101;
    ADCSRA = (uint8_t)0b10000111;
    ADCSRB = (uint8_t)0b00000000;
    DIDR0 =  (uint8_t)0b00100000;

    ADCSRA |= (uint8_t)(1 << ADEN);

    while (1)
    {
        ADCSRA |= (uint8_t)(1 << ADSC);
        while(ADCSRA & (uint8_t)(1 << ADSC));
        PORTB = (uint8_t)ADCL;
    }
}
