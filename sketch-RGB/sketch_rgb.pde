
import processing.video.*;
import oscP5.*;
import netP5.*;

Capture cam;
OscP5 oscP5;
NetAddress wekinator;

// Size of the color detection area
int boxSize = 100;

float avgR = 0;
float avgG = 0;
float avgB = 0;

String detectedColor = "Unknown";

void setup() {
  size(640, 480);

  println(Capture.list());

  cam = new Capture(this, 640, 480);
  cam.start();

  // Local OSC port
  oscP5 = new OscP5(this, 9000);

  // Wekinator input
  wekinator = new NetAddress("127.0.0.1", 6448);

  textSize(18);
}

void captureEvent(Capture c) {
  c.read();
}

void draw() {
  background(0);

  if (cam.width == 0 || cam.height == 0) {
    return;
  }

  image(cam, 0, 0, width, height);
  cam.loadPixels();

  // Center detection box
  int startX = (cam.width - boxSize) / 2;
  int startY = (cam.height - boxSize) / 2;

  float sumR = 0;
  float sumG = 0;
  float sumB = 0;
  int count = 0;

  // Sample pixels inside the box
  for (int y = startY; y < startY + boxSize; y += 5) {
    for (int x = startX; x < startX + boxSize; x += 5) {

      int index = x + y * cam.width;
      color c = cam.pixels[index];

      sumR += red(c);
      sumG += green(c);
      sumB += blue(c);

      count++;
    }
  }

  // Average RGB values, normalized to 0-1
  if (count > 0) {
    avgR = sumR / count / 255.0;
    avgG = sumG / count / 255.0;
    avgB = sumB / count / 255.0;
  }

  // Detect dominant color for display
  if (avgR > avgG * 1.25 && avgR > avgB * 1.25) {
    detectedColor = "RED";
  }
  else if (avgG > avgR * 1.25 && avgG > avgB * 1.25) {
    detectedColor = "GREEN";
  }
  else if (avgB > avgR * 1.25 && avgB > avgG * 1.25) {
    detectedColor = "BLUE";
  }
  else {
    detectedColor = "MIXED / NEUTRAL";
  }

  // Send three RGB values to Wekinator
  OscMessage msg = new OscMessage("/wek/inputs");

  msg.add(avgR);
  msg.add(avgG);
  msg.add(avgB);

  oscP5.send(msg, wekinator);

  // Draw detection box
  noFill();
  stroke(255, 255, 0);
  strokeWeight(3);
  rect((width - boxSize) / 2,
       (height - boxSize) / 2,
       boxSize, boxSize);

  // Display values
  noStroke();
  fill(0, 180);
  rect(0, height - 110, width, 110);

  fill(255);
  text("R: " + nf(avgR, 1, 2), 20, height - 78);
  text("G: " + nf(avgG, 1, 2), 170, height - 78);
  text("B: " + nf(avgB, 1, 2), 320, height - 78);

  text("Detected: " + detectedColor, 20, height - 35);
}
