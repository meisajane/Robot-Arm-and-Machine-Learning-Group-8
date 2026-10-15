#include <Servo.h>

Servo l;
Servo r;
Servo claw;
Servo base;

// 四个电位器的引脚
int potL    = A0;
int potR    = A1;
int potClaw = A2;
int potBase = A3;

void setup() {
  l.attach(12);
  r.attach(11);
  claw.attach(10);
  base.attach(9);
}

void loop() {
  l.write(map(analogRead(potL),       0, 1023, 0, 180));
  r.write(map(analogRead(potR),       0, 1023, 0, 180));
  claw.write(map(analogRead(potClaw), 0, 1023, 0, 180));
  base.write(map(analogRead(potBase), 0, 1023, 0, 180));
  delay(15);
}