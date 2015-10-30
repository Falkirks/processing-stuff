int x = 500;
int y = 500;
PImage img;
void setup(){
  background(0);
  size(500,500);
}
void draw(){

 if(img != null){
    frame.setSize(x,y);
  setSize(x,y);
   background(0);
 image(img,0,0);
 }
  
}
void mouseReleased(){
  selectInput("select an image:","callback");
}
void callback(File f){
  img = loadImage(f.getAbsolutePath());
  x = img.width;
  y = img.height+20;
}
