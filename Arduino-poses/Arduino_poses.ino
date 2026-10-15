#include <Servo.h>

Servo l;
Servo r;
Servo claw;
Servo base;

void setup() {
  l.attach(12);
  r.attach(11);
  claw.attach(10);
  base.attach(9);

  Serial.begin(9600);

  //l.write(90);
  //r.write(90);
  claw.write(110);   // initial: open
 // base.write(90);
}

void loop() {
  if (Serial.available() > 0) {

    int message = Serial.read();

    if (message == 1) {
      claw.write(70);
      base.write(45);
      r.write(90);    // red -> open
    }

    else if (message == 2) {
      claw.write(180);
      base.write(0);
      r.write(160); // black -> close
    }

    else if (message == 3) {
      claw.write(180);
      base.write(130);
      r.write(20); // blue -> shy
    }
  }
}