class paddle{
  int y;
  int size = 125;
  Boolean up = false;
  Boolean down = false;
  int score = 0;
  int speed = 0;
  paddle(){
    y = height/2;
  }
  void move(){
   if(up || down){
    if(up && y-10 > size/2) y -= (int) 3+speed/2;
    if(down && y+10 < 600-size/2) y += (int) 3+speed/2;
    speed++;
    if(speed > 30) speed = 30;
   }
   else speed = 0;
  }
  
}
