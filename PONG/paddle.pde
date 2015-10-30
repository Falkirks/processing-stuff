class Paddle {
  float y;
  int size = 125;
  Boolean up = false;
  Boolean down = false;
  int score = 0;
  float speed = 0;
  Paddle() {
    y = height/2;
  }
  void move() {
    if (up || down) {
      if (up) {
        y -=  4+speed/3;
        if (y-(size/2)-10 < 0) y = size/2+10;
        else speed += 0.75;
      }
      if (down) {
        y +=  4+speed/3;
        if (y+(size/2)+10 > height) y = height-(size/2)-10;
        else speed += 0.75;
      }
      if (speed > 30) speed = 30;
    }
    else speed = 0;
  }
}

