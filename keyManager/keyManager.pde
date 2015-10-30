bindKey keys;
void setup(){
  size(800,600);
  keys = new bindKey();
}
void draw(){
  if(keys.isPressed(UP) && keys.isPressed(DOWN)) background(0);
  else if(keys.count() > 3) background(255,0,0);
  else background(255);
  
  println(keys.get());
  
}
void keyPressed(){
  keys.pressKey(keyCode);
}
void keyReleased(){
  keys.releaseKey(keyCode);
}
