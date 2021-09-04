#include <Arduino.h>



#define DOT_LENGTH 200
#define DASH_LENGTH DOT_LENGTH * 3


void setup() {
  pinMode(LED_BUILTIN, OUTPUT);
}

void dot(){
    digitalWrite(LED_BUILTIN, HIGH);
    delay(DOT_LENGTH);
    digitalWrite(LED_BUILTIN, LOW);
    delay(DOT_LENGTH);
}

void dash(){
    digitalWrite(LED_BUILTIN, HIGH);
    delay(DASH_LENGTH);
    digitalWrite(LED_BUILTIN, LOW);
    delay(DASH_LENGTH);
}

void sos(){
    dot();
    dot();
    dot();
    dash();
    dash();
    dash();
}

void loop() {
    sos();
}
