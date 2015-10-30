void setup() {
  size(1000, 1000, P3D); 
}
PImage img = loadImage("credit.png");
void draw() {
  background(200);
  texture(img);
  translate(height/2, width/2, 0);
  rotateX(mouseY * 0.05);
  rotateY(mouseX * 0.05);
  sphere(250);
}
