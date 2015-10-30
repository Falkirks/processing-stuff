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

public class withcam extends PApplet {

int[] b;
public void setup(){
  size(1000,1000,P3D);
  colorMode(RGB, 255, 255, 1, 175);
  b = new int[10000];
  frameRate(30);
loop();
}
int x = 0;
int y = 0;
int inc = 0;
public void draw(){
  lights();
   background(175);
    camera(mouseX*1.5f, mouseY*2.5f, (height/2.0f) / tan(PI*60.0f / 360.0f),
         width/2.0f, height/2.0f, 0, // centerX, centerY, centerZ
         0.0f, 1.0f, 0.0f);
  for (int intValue : b) {
    if(x == 1000){
      x = 0;
      y = y + 10;
    }
    fill(30,130,noise(y,x));
    pushMatrix();
    translate(x,y);
    noStroke();
    box(10,10,noise(x,y,inc)*255);
    x = x + 10;
       popMatrix();
       if(x == 1000 && y == 1000){
         x = 0;
         y = 0;
       }
}
inc++;
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "withcam" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
