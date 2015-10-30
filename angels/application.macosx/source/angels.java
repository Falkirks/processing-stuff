import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class angels extends PApplet {

int tick = 0;
int set = 0;
public void setup(){
  size(displayWidth,displayHeight);
  println("Don't blink!");
}
public void draw(){
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
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "angels" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
