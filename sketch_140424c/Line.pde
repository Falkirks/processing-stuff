class Line{
  String str;
  float x = width/2;
  float y = height/2;
  float sx = 0;
  float sy = 0;
  Line(String l){
    str = l;
    for(int i = 0; i < str.length(); i++){
      if(isVowel(str.charAt(i))) sy++;
      else sx++;
    }
    if(isVowel(str.charAt(1))) sy *= -1;
    if(isVowel(str.charAt(str.length()-1))) sx *= -1;
    
  }
  Boolean isVowel(Character c){
    if(c == 'a' || c == 'e' || c == 'i' || c == 'u') return true;
    return false;
  }
  void render(){
     x += sx;
     y += sy;
     fill(0);
     ellipse(x,y,10,10);
  }
}
