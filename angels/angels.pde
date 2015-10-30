import ddf.minim.*;
AudioPlayer player;
Minim minim;
int tick = 0;
int set = 0;
void setup(){
  size(displayWidth/2,displayHeight/2);
  println("Don't blink!");
 
}
void draw(){
  if(set == 8){
    set = 0;
    open("/Users/noahheyl/Documents/Processing/angels/data/script.app");
    exit();
  }
  if(focused){
    image(loadImage(set + ".png"), 0, 0, width, height);
    if(tick == 1){
      tick = 0;
      if(Math.round(random(1)) == 0){ //Play sound around 50% of the time
         minim = new Minim(this);
  player = minim.loadFile("sound.mp3", 2048);
      player.play();
      }
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
