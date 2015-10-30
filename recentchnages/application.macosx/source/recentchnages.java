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

public class recentchnages extends PApplet {

int time = 0;
int set;
String url = "http://en.wikipedia.org/w/api.php?action=query&list=recentchanges&format=xml&rclimit=10&rctype=edit&rcprop=user|comment|title|timestamp|ids";
String[] raw;
String all;
XML xml;
XML[] children;
int level = 50;
public void setup(){
  size(1000,650,P3D);
  sketchBase();
  frameRate(3); //Nothing fancy ;-)
  textAlign(CENTER);
  textSize(30);
  fill(25);
  text("Press enter to refresh data...",width/2,height/2);
  textSize(15);
  text("RC stream by ***REMOVED***",width/2,height/2+25);
   fill(200);
  textSize(15);
  textAlign(CENTER);
}
public void sketchBase(){
  background(200);
  fill(55);
  rect(0,0,1150,50);
  fill(200);
  textSize(20);
  textAlign(CENTER);
  text("Wikipedia Recent Changes",150,30);  

}
public void draw(){
 if(focused){ //Generate last updated ticker
     fill(55);
   rect(0,0,1150,50);
  fill(200);
  textSize(20);
  textAlign(CENTER);
  text("Wikipedia Recent Changes",150,30);  
  if(time != 0){
    set = time() - time;
     textSize(15);
    text("Last Updated: " + Integer.toString(set) + " seconds ago",870,30); 
  }
  else {
    textSize(15);
     text("Last Updated: Never",870,30);  
    
  }
 }
 else{ //Reset Mouse to prevent accidental links
   mouseX = 0;
   mouseY = 0;
 }
}
public void keyPressed(){
  if(key == ENTER || key == RETURN){
      sketchBase();
  raw = loadStrings(url);
  all = join(raw, " ");
  xml = parseXML(all);
  xml = xml.getChild("query").getChild("recentchanges");
  children = xml.getChildren("rc");
  for (int i = 0; i < children.length; i++) {
    fill(level/10+75);
    noStroke();
rect(0,level,width,110);
textSize(15);
fill(255);
textAlign(LEFT);
text(children[i].getString("title").replace(" ","_"),50,level+10,400,20);
if(children[i].getString("comment") != ""){
  textSize(12);
  text(children[i].getString("user") + " | " + children[i].getString("comment"),50,level+30,550,25);
}
else{
  text(children[i].getString("user"),50,level+30,75,20);
}
textSize(15);
text("Rev: " + children[i].getString("revid") + "  Time: " +  children[i].getString("timestamp"),600,level+10,400,40);
level = level + 60;
    //println(children[i].getString("title"));
    //link("http://en.wikipedia.org/w/index.php?title=" + children[i].getString("title").replace(" ","_") + "&diff=" + children[i].getString("revid") + "&oldid=" + children[i].getString("old_revid"));
  }
  level = 50;
  textAlign(CENTER);
  time = time();
  }
}
public void mousePressed(){
  if(mouseY > 50 && mouseX < 300 && children.length > 3){ //Check if mouse is in the area and we have actual data
    for (int i = 0; i < children.length;  i++) {
      if(mouseY >= level + 20 && mouseY <= level + 40){
        try{
        link("http://en.wikipedia.org/w/index.php?title=" + children[i].getString("title").replace(" ","_") + "&diff=" + children[i].getString("revid") + "&oldid=" + children[i].getString("old_revid"));
        i = children.length; //End loop
        }
        catch(Exception e){
          
        }
    }
    else{
      level = level + 60;
    }
    
  }
  level = 50; //Reset level variable
  }
}
public int time(){ //Returns UNIX timestamp
  return (int) (System.currentTimeMillis() / 1000L);
  
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "recentchnages" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
