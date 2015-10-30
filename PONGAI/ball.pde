class Ball {
  float x;
  float y;
  float sx = 0;
  float sy = 0;
  Boolean started = false;
  Ball() {
    x = width/2;
    y = height/2;
  }
  void start(int speed) {
    if (!started) {
      if (random(-1, 1) >= 0) sx = speed; 
      else sx = speed * -1;
      sy = random((speed * -1)-1, speed+1);
      started = true;
    }
  }
  void update() {
    if (started) {
      if (Math.abs(sy) > 6)  sy /= 1.1;
      y += sy;
      x += sx;
      //Check collisions with top and bottom
      if (y+10 >= height) { 
        sy *= -1;
        y = height-11;
      }
      if (y-10 <= 0) {
        sy *= -1;
        y = 11;
      }
      //Check collisions with left and right
      if (x+10 > width) {
        reset();
        p1.score++;
      }
      if (x-10 < 0) {
        reset();
        p2.score++;
      }
       //Check paddle collisons 
      if (x <= 55 && x >= 35 && y+10 >= p1.y-p1.size/2 && y-10 <= p1.y+p1.size/2) collide(p1.speed);
      if (x >= width-55 && x <= width-35 && y+10 >= p2.y-p2.size/2 && y-10 <= p2.y+p2.size/2) collide(p2.speed);
    }
  }
  void reset() {
    x = width/2;
    y = height/2;

    sx *= -1;
    sy = random(-2, 2);
  }
  void collide(Float speed) {
    if (sy > 0) sy += speed/3;
    else sy -= speed/3;
    sx *= -1;
  }
}

