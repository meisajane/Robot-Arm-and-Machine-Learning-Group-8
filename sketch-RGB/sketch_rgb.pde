import processing.video.*;
import oscP5.*;
import netP5.*;

Capture cam;
OscP5 oscP5;
NetAddress wekinator;
int boxSize = 100;

void setup() {
  size(640, 480);
  cam = new Capture(this, 640, 480);
  cam.start();
  oscP5 = new OscP5(this, 9000);
  wekinator = new NetAddress("127.0.0.1", 6448);
  textSize(18);
}

void captureEvent(Capture c) {
  c.read();
}

void draw() {
  if (cam.width == 0) return;
  image(cam, 0, 0);
  cam.loadPixels();

  // Sample the centre box and average its RGB values (normalised to 0-1)
  int x0 = (width - boxSize) / 2, y0 = (height - boxSize) / 2;
  float r = 0, g = 0, b = 0;
  int n = 0;
  for (int y = y0; y < y0 + boxSize; y += 5) {
    for (int x = x0; x < x0 + boxSize; x += 5) {
      color c = cam.pixels[x + y * cam.width];
      r += red(c);  g += green(c);  b += blue(c);
      n++;
    }
  }
  r /= n * 255.0;  g /= n * 255.0;  b /= n * 255.0;

  // Send the three values to Wekinator
  OscMessage msg = new OscMessage("/wek/inputs");
  msg.add(new float[] {r, g, b});
  oscP5.send(msg, wekinator);

  // Dominant colour label (display only, Wekinator does the real classification)
  String label = (r > g*1.25 && r > b*1.25) ? "RED"
               : (g > r*1.25 && g > b*1.25) ? "GREEN"
               : (b > r*1.25 && b > g*1.25) ? "BLUE" : "MIXED / NEUTRAL";

  // Draw the detection box
  noFill();  stroke(255, 255, 0);  strokeWeight(3);
  rect(x0, y0, boxSize, boxSize);

  // Draw the info bar with RGB values and label
  noStroke();  fill(0, 180);
  rect(0, height - 110, width, 110);
  fill(255);
  text("R: " + nf(r, 1, 2) + "   G: " + nf(g, 1, 2) + "   B: " + nf(b, 1, 2), 20, height - 78);
  text("Detected: " + label, 20, height - 35);
}
