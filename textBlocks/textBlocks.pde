void setup(){
size(displayWidth,displayHeight,OPENGL);
}
void draw(){

}
class TextBlock{
  int x;
  int y;
  color c;
  textBlock(){
    x = random(0,displayWidth);
    y = random(0,displayHeight);
    c = color(random(50), random(255), random(255), 100);
  }
}
