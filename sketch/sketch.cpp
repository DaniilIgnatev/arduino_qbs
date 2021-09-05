/*
 * adc.cpp
 *
 * Created: 04.09.2021 19:03:02
 * Author : daniil
 */

#include <Arduino.h>


void setup(){
    pinMode(LED_BUILTIN, OUTPUT);

}


void loop(){
    digitalWrite(LED_BUILTIN, HIGH);
    delay(1000);
    digitalWrite(LED_BUILTIN, LOW);
    delay(1000);
}
