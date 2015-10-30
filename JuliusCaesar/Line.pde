class Line {
  String str;
  float x = width/2;
  float y = height/2;
  float sx = 0;
  float sy = 0;
  Line(String l) {
    str = l;
    Boolean addX = true;
    int c = 0;
    for (int i = 0; i < str.length(); i++) {
      if (str.charAt(i) == ' ') {
        if (addX) sx += c;
        else sy += c;
        addX = !addX;
        c = 0;
      }
      else {
        if (isVowel(str.charAt(i))) c += 2;
        else c += 1;
      }
    }  
    if (sx >= sy) sy *= -1;
    if (abs(sy) >= sx) sx *= -1;
    sy *= 0.3;
    sx *= 0.3;
  }
  Boolean isVowel(Character c) {
    if (c == 'a' || c == 'e' || c == 'i' || c == 'u') return true;
    return false;
  }
  void render() {
    x += sx;
    y += sy;
    if (x >= 794 || x <= 6) sx *= -1;
    if (y >= 594 || y <= 6) sy *= -1;
    noStroke();
    fill((abs(sx)+abs(sy))*10);
    ellipse(x, y, 10, 10);
  }
}

