void setup(){
  size(1000,650,P3D);
  
  sketchBase();
  textAlign(CENTER);
  textSize(30);
  fill(25);
  text("Press enter to refresh data...",width/2,height/2);
}
void sketchBase(){
  background(200);
  fill(55);
  rect(0,0,1150,50);
  fill(200);
  textSize(20);
  textAlign(CENTER);
  text("Wikipedia Recent Changes",150,30);
}
void draw(){
 
}
String url = "http://en.wikipedia.org/w/api.php?action=query&list=recentchanges&format=xml&rclimit=10&rctype=edit";
String[] raw;
String all;
XML xml;
XML[] children;
int level = 50;
void keyPressed(){
  if(key == ENTER || key == RETURN){
      sketchBase();
  raw = loadStrings(url);
  all = join(raw, " ");
  xml = parseXML(all);
  xml = xml.getChild("query").getChild("recentchanges");
  children = xml.getChildren("rc");
  for (int i = 0; i < children.length; i++) {
    fill(level/10);
    noStroke();
rect(0,level,width,110);
textSize(20);
fill(255);
textAlign(LEFT);
text(children[i].getString("title").replace(" ","_"),50,level+20,400,30);
textSize(15);
text("Rev: " + children[i].getString("revid") + "  Time: " +  children[i].getString("timestamp"),500,level+10,400,40);
level = level + 60;
    //println(children[i].getString("title"));
    //link("http://en.wikipedia.org/w/index.php?title=" + children[i].getString("title").replace(" ","_") + "&diff=" + children[i].getString("revid") + "&oldid=" + children[i].getString("old_revid"));
  }
  level = 50;
  }
}
void mousePressed(){
  if(mouseY > 50){
    for (int i = 0; i < children.length;  i++) {
      if(mouseY >= level && mouseY <= level + 60){
        link("http://en.wikipedia.org/w/index.php?title=" + children[i].getString("title").replace(" ","_") + "&diff=" + children[i].getString("revid") + "&oldid=" + children[i].getString("old_revid"));
        i = children.length;
    }
    else{
      level = level + 60;
    }
    
  }
  level = 50;
  }
}
