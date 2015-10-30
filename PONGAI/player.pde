class Player {
  float bx;
  float by;
  Player() {
    bx = width/2;
    by = height/2;
  }
  void think() {
    if (ball.started) {
      by = ball.y-(ball.sy*6.3);
        if (by < p2.y-(p2.size/2)+35) p2.up = true;
        else p2.up = false;
        if (by > p2.y+(p2.size/2)-35) p2.down = true;
        else p2.down = false;
        println(by);
    }
  }
}

