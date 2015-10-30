int[] b;
void setup(){
  size(1000,1000,P3D);
  colorMode(RGB, 255, 255, 1, 175);
  b = new int[10000];
  frameRate(30);
loop();
}
int x = 0;
int y = 0;
int inc = 0;
void draw(){
  lights();
   background(175);
    camera(mouseX*1.5, mouseY*2.5, (height/2.0) / tan(PI*60.0 / 360.0),
         width/2.0, height/2.0, 0, // centerX, centerY, centerZ
         0.0, 1.0, 0.0);
  for (int intValue : b) {
    if(x == 1000){
      x = 0;
      y = y + 10;
    }
    fill(30,130,noise(y,x));
    pushMatrix();
    translate(x,y);
    noStroke();
    box(10,10,noise(x,y,inc)*255);
    x = x + 10;
       popMatrix();
       if(x == 1000 && y == 1000){
         x = 0;
         y = 0;
       }
}
inc++;
}
