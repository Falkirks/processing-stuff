Ball[] balls = new Ball[100];
void setup(){
  size(800,600,OPENGL);
  background(0);
  for(int i = 0; i < balls.length; i++) balls[i] = new Ball(55);
}
void draw(){
  lights();
 for(int i = 0; i < balls.length; i++){
   balls[i].render();
   balls[i].check();
 }
}
class Ball{
  float x;
  float y;
  float z;
  float vx;
  float vy;
  float vz;
  color c;
  int s;
  Ball(int size){
    s = size;
    c = color(random(50), random(255), random(255));
    x = random(0,width);
    y = random(0,height);
    z = 0;
    vx = 2;
    vy = 2;
    vz = -2;
  }
  void check(){
    if(x >= 800-s || x <= 0) vx *= -1;
    if(y >= 600-s || y <= 0) vy *= -1;
    if(z >= s || z <= -700) vz *= -1;
  }
 void render(){
   pushMatrix();
   //translate(x,y,z);
   stroke(c);
   noFill();
   line(x,y,z,x+vx,y+vy,z+vz);
   popMatrix();
    x += vx;
    y += vy;
    z += vz;
 }
}


