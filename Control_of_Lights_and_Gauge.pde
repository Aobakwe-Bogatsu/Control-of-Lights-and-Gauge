// ==== Declare Variables ====

// Number of LEDs
int numLEDs = 4;

// Arrays for LED colors and labels
color[] ledColors;
String[] labels;

// Colors
color defaultColor;
color color1;
color color2;

// LED dimensions (Width & Height = 50px)
int ledWidth = 50;
int ledHeight = 50;

// LED layout configuration
int startX = 75;       // X-position for the first LED (Canvas padding: 50px + half LED = 75px)
int spacing = 100;     // Distance from center to center: 25 (left space) + 50 (LED) + 25 (right space) = 100px

// Gauge bar configuration
int gaugeWidth = 350;     // Width of the gauge bar spanning from left to right LED
int gaugeHeight = 20;     // Height of the gauge bar
float gaugeValue = 0;     // Initial gauge fill (0%)
int percentage = 0;       // Percentage display below gauge bar

// ==== SETUP FUNCTION ====
// Called once at program start
void setup() {
  size(450, 180);        // Canvas size: 450px wide (50 left + 4 LEDs * 50 + 3 spaces * 50 + 50 right), 180px tall

  noStroke();            // Disable border for shapes

  // Initialize color values
  defaultColor = color(#80808080);  // Default gray color with transparency
  color1 = color(#FFFF00);          // Yellow (left click)
  color2 = color(#FF00FF);          // Purple (right click)

  // Initialize arrays for LED colors and labels
  ledColors = new color[numLEDs];
  labels = new String[numLEDs];

  for (int i = 0; i < numLEDs; i++) {
    ledColors[i] = defaultColor;    // Set all LEDs to default gray
    labels[i] = "Grey";             // Label all LEDs as "Grey" initially
  }
}

// ==== DRAW FUNCTION ====
// Continuously updates the display
void draw() {
  background(225);    // Clear the canvas with a light gray background each frame

  // ==== Draw LEDs and Labels ====
  for (int i = 0; i < numLEDs; i++) {
    float x = startX + i * spacing;    // Calculate center X position for each LED

    // Draw LED circle
    fill(ledColors[i]);
    ellipse(x, 65, ledWidth, ledHeight);  // Y = 65 (40px from top + 25px half-height)

    // Draw label above LED
    textSize(20);
    fill(0);                 // Black text
    textAlign(CENTER);
    text(labels[i], x, 20);  // Y = 20px from top (label position)
  }

  // ==== Draw Gauge Bar Background ====
  fill(225); 
  rect(50, 120, gaugeWidth, gaugeHeight);  // Y = 120 (65 + 25 (half LED) + 30 spacing)

  // ==== Draw Gauge Fill ====
  fill(#00FF00);             // Lime green color
  float barWidth = map(gaugeValue, 0, 100, 0, gaugeWidth);
  rect(50, 120, barWidth, gaugeHeight);  // Only filled according to current gaugeValue

  // ==== Display Percentage Text ====
  textSize(20);
  fill(0);
  textAlign(LEFT);
  text(percentage + "%", 50, 160);        // Y = 120 (gauge) + 20 (height) + 20 (spacing) = 160
}

// ==== MOUSE INTERACTION ====
// Called when mouse is pressed
void mousePressed() {
  for (int i = 0; i < numLEDs; i++) {
    float x = startX + i * spacing;
    int y = 40;  // Top edge Y of LED zone for click detection

    // Detect click inside LED bounding box
    if (mouseX > x - ledWidth / 2 && mouseX < x + ledWidth / 2 &&
        mouseY > y && mouseY < y + ledHeight) {

      if (mouseButton == LEFT) {
        ledColors[i] = color1;
        labels[i] = "Yellow";
      } else if (mouseButton == RIGHT) {
        ledColors[i] = color2;
        labels[i] = "Purple";
      }
    }
  }
}

// ==== KEYBOARD INTERACTION ====
// Called when a key is pressed
void keyPressed() {
  if (keyCode == RIGHT && gaugeValue < 100) {
    gaugeValue++;      // Increase gauge value by 1%
    percentage++;
  } else if (keyCode == LEFT && gaugeValue > 0) {
    gaugeValue--;      // Decrease gauge value by 1%
    percentage--;
  }
}
