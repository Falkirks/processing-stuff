int[] b;
void setup(){
  size(1000,1000,P3D);
  colorMode(RGB, 255, 255, 1, 175);
  background(175);
  b = new int[10000];
    for(int i = 0; i < 10000; i++){
    b[i] = Math.round(random(175));
}
}
int x = 0;
int y = 0;
void draw(){
  lights();
  
  for (int intValue : b) {
    if(x == 1000){
      x = 0;
      y = y + 10;
    }
    fill(30,130,noise(y,x));
    pushMatrix();
    translate(x,y);
    noStroke();
    box(10,10,noise(x,y)*255);
    x = x + 10;
       popMatrix();
}
}
