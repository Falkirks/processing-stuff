class sBall {
  int x;
  int y;
  float sx = 1.5;
  float sy = 2.5;
  sBall() { 
    x = width/2;
    y = 175;
  }
  void render() {
    if (x+sx <= 297 || x+sx >= 505) sx *= -1;
    if (y+sy <= 142 || y+sy >= 200) sy *= -1;
    x += sx;
    y += sy;
    fill(38, 139, 210);
    noStroke();
    ellipse(x, y, 20, 20);
  }
}

