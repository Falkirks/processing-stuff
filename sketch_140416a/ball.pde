class ball{
  int x;
  int y;
  int sx = 0;
  float sy = 0;
  ball(){
    x = width/2;
    y = height/2;
  }
  void start(){
    if(Math.abs(sx) != 4){
    if(random(-1,1) >= 1.0) sx = 4; 
    else sx = -4;
    
   sy = random(-5,5);
    }
  }
  void update(){
    
    if(sx == sy && sy != 0){
      if(sy > 0) sy = random(0,5);
      else sy = random(-5,0);
    }
    y += sy;
    x += sx;
    if(y >= 600) sy *= -1;
    if(y <= 0) sy *= -1;
    
  }
  void reset(){
   x = width/2;
   y = height/2;
   sx *= -1;
 sy = random(-5,5);
  }
  void collide(){
    sx *= -1;
  }
}
