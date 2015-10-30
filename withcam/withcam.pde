void setup(){
  size(1000,700,OPENGL);
  colorMode(RGB, 255, 255, 1, 175);
  smooth(6);
}
float inc = 0;
void draw(){
   background(245);
    lights();
    float px = 0;
    float py = 0;
  translate(0,0,-200);
  stroke(0);
  strokeWeight(2);
  beginShape(POINTS);
  for (int i = 0; i < 100*800; i += 10) {
    if(i % width == 0){
      px = 0;
      py += 0.02;
    }
    vertex(px*500,py*500,-200+noise(px,py,inc)*255);
    px += 0.02;
}
  endShape();
  inc += 0.07;
  }
void mouseDragged() {

camera(mouseX*1.5, mouseY*2.5, (height/2.0) / tan(PI*60.0 / 360.0),
         width/2.0, height/2.0, 0, 0.0, 1.0, 0.0);
}
