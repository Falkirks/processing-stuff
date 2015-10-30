PGraphics[] pg = new PGraphics[10]; //Graphics objects
int pgCurr = 1; //Current canvas
float s = 0.2; //StrokeWeight
color c = color(0); //Color
Boolean drawing = false; //Drawing?
Boolean help = false; //Help menu toggle
PImage load; //Loaded image
int lx, ly; //Image width, height
void setup() {
  size(800, 600);
  background(155);
  frame.setResizable(true);
  for (int i = 0; i < 10; i++) pg[i] = createGraphics(displayWidth, displayHeight); //Create graphics objects
  println("Press '?' for help");
}
void draw() {
checkBoundries();
  Boolean e = false;
  pg[pgCurr].beginDraw();
 Boolean img = imageLoader(); //Should a preview img be placed
  if (keyPressed) {
    if (key == BACKSPACE) pg[pgCurr].background(155);
    if (Character.isDigit(key)){
      pgCurr = Character.getNumericValue(key);
        frame.setTitle("Currently drawing to " + pgCurr);
    }
    int ikey = (int) key;
    if (ikey <= 122 && ikey >= 97) c = color(Math.round(map(ikey-96, 1, 26, 0, 255)));
    if (key == '?' || key == '/') toggleHelp();
    if (key == 'S') selectOutput("Save as...", "handleSave");
    if (key == 'O') selectInput("Open", "handleLoad");
    keyPressed = false;
    if(keyCode == UP || keyCode == DOWN) keyPressed = true;
  }
  if (mousePressed && load == null) {
    if (Math.abs(mouseX-pmouseX) < 5 && Math.abs(mouseY-pmouseY) < 5 && !drawing) {
      s += 0.5;
      e = true;
    }
    else{
      pg[pgCurr].strokeWeight(s);
      pg[pgCurr].stroke(c);
      pg[pgCurr].line(pmouseX, pmouseY, mouseX, mouseY);
      drawing = true;
    }
  }
  else {
    drawing = false;
    s = 0.2;
  }
  pg[pgCurr].endDraw();
  background(155);
  imageMode(CORNER);
  image(pg[pgCurr], 0, 0);
  fill(c);
  noStroke();

  if (e) ellipse(mouseX, mouseY, s, s);
  if (help) drawHelp();
  if(img){
    imageMode(CENTER);
    image(load,mouseX,mouseY,lx,ly);
  }
}
void drawHelp() {
  textAlign(LEFT);
  fill(55);
  rectMode(CORNER);
  rect(0, 0, 300, height);
  textSize(30);
  fill(210);
  text("Need Help?", 20, 50);
  textSize(14);
  text("This program makes use of your keyboard to draw without a control panel getting in the way. All alphabetic keys from a to z control colour (a is black and z is white). You can change stroke weight by clicking and holding where you want to start drawing. Numeric keys 0-9 control the drawing canvas, you can easily flip between 10 active drawings during your session. The BACKSPACE key will wipe the current canvas. Command keys use the upper case of alphabetic keys, so make sure caps lock is off. To save your canvas you can use S and to load a canvas use O (Scale with UP and DOWN, BACKSPACE to stop). Also, the drawing frame is fully resizabled! You may notice some flickering when you change window size. Processing can lose mouse when resizing too fast, just move it in and out of the window and it should fix.", 20, 60, 275, height-30);
  textSize(10);
  textAlign(CENTER);
  text("Frame Rate:" + frameRate + " | Frame Count:" + frameCount, 150, height-10);
}
void toggleHelp() {
  if (help) help = false;
  else help = true;
}
void handleSave(File f) {
  if (f != null && f.getAbsolutePath().substring(f.getAbsolutePath().length()-4).equals(".png")) pg[pgCurr].get(0, 0, width, height).save(f.getAbsolutePath());
  else println("Save cancelled or unsupported file type.");
}
void handleLoad(File f) {
  if (f != null){
    load = loadImage(f.getAbsolutePath());
    lx = load.width;
    ly = load.height;
  }
}
Boolean imageLoader() { //Manages loaded images and placment
  if(load == null) return false;
  if (keyPressed && key == BACKSPACE){
    load = null;
    keyPressed = false;
    return false;
  }
  else if (keyPressed && keyCode == UP){
    //Prevent continous rounding down when image is too small
    lx = (int) Math.ceil(lx*1.01);
    ly = (int) Math.ceil(ly*1.01);
  }
  else if (keyPressed && keyCode == DOWN && lx > 1 && ly > 1){
    lx /= 1.01;
    ly /= 1.01;
  }
  if (!mousePressed) return true;
 pg[pgCurr].image(load,mouseX-(lx/2),mouseY-(ly/2),lx,ly);
  return false;
}
void checkBoundries(){
    if(width > displayWidth){
    frame.setSize(displayWidth,height);
    setSize(displayWidth,height);
  }
    if(height > displayHeight){
    frame.setSize(width,displayHeight);
    setSize(width,displayHeight);
  }
}
