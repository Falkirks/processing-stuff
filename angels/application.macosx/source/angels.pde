int tick = 0;
int set = 0;
void setup(){
  size(displayWidth,displayHeight);
  println("Don't blink!");
}
void draw(){
  if(set == 8){
    exit();
    print(" You lost, better luck next time ;-)");
  }
  if(focused){
    image(loadImage(set + ".png"), 0, 0, width, height);
    if(tick == 1){
      tick = 0;
    }
  }
  else{
    background(0);
    if(tick == 0 && set != 8){
      tick++;
      
          set++;
    }
    else{
      
    }
  }
}
