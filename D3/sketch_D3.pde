
import processing.serial.*;

Serial port;

void setup() {
  size(500, 250);

  // Show available serial ports
  println("Available serial ports:");
  printArray(Serial.list());

  // Change [3] to your Arduino port index
  port = new Serial(this, Serial.list()[3], 9600);

  println("Serial connection ready!");
}

void draw() {
  background(240);

  fill(0);
  textSize(22);
  text("D3 - Serial Communication Test", 35, 65);

  textSize(18);
  text("Press 1 = Pose 1", 35, 115);
  text("Press 2 = Pose 2", 35, 150);
  text("Press 3 = Pose 3", 35, 185);
}

void keyPressed() {

  if (key == '1' || key == '2' || key == '3') {

    // Convert keyboard character to a numeric byte
    int command = key - '0';

    // Send the command to Arduino
    port.write(command);

    println("Sent to Arduino: " + command);
  }
}
