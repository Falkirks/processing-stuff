/*
Example implementaion of Baycentric Coords to make a triangle button.
Try changing x and y values to make different triangles.
*/
float x1 = 42.265;
float y1 = 150;
float x2 = 100;
float y2 = 50;
float x3 = 157.735;
float y3 = 150;
void setup() {
  size(200, 200);
  background(45);
}
void draw() {
  background(45);
  noStroke();
  float a = ((y2 - y3)*(mouseX - x3) + (x3 - x2)*(mouseY - y3)) / ((y2 - y3)*(x1 - x3) + (x3 - x2)*(y1 - y3));
  float b = ((y3 - y1)*(mouseX - x3) + (x1 - x3)*(mouseY - y3)) / ((y2 - y3)*(x1 - x3) + (x3 - x2)*(y1 - y3));
  float c = 1 - a - b;
  if (a >= 0 && a <= 1 && b >= 0 && b <= 1 && c >= 0 && c <= 1 && mousePressed) fill(255, 0, 0);
  else fill(230);
  triangle(x1, y1, x2, y2, x3, y3);
}

