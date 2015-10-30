import hypermedia.net.*;
color c = color(55); //Current color
float s = 10; //Brush size
PImage g; //Color Gradient
PImage open; //Open icon
PImage erase; //Eraser icon
PImage clear; //Clear icon
PImage save; //Save icon
PImage random; //Random icon
PImage wifi; //Multicast icon
Boolean mc = false;
PImage load; //Storage for image imports
String savepath; //Current save path
Boolean backImport = true; //When set to true image imports will be sent to back
Boolean newimg = false; //Current importing image is not an exported image
Boolean canvasWaiting = false; //Used to download a canvas via multicast
int canvasSent = 0; //Canvas data sent
int canvasGot = 0; //Canvas data recieved
int waiting = 0; //Waiting since frameCount
ArrayList<String[]> UDPline = new ArrayList<String[]>(); //UDP packet arrays
UDP udp; //UDP object
void setup() {
  size(800, 600, P2D);
  background(55);
}
void draw() {
  if (frameCount == 1) {
    loadSketch();
    return;
  }
  if (frameCount > waiting+200 && canvasWaiting && waiting != -10) { //timeout canvas 
    println("Canvas not recieved");
    canvasWaiting = false;
    waiting = 0;
  }
  frame.setTitle("Drawing - Frame Rate: " + frameRate);
  if (savepath != null) { //Is there a save waiting?
    Save(); 
    savepath = null;
  }
  if (load != null && !newimg) { //Is there an import waiting, but not another image
    transferImage(load); 
    load = null;
  }
  if (UDPline.size() > 0) {
    for (int i = 0; i < UDPline.size(); i++) {
      if (i > 2) break;
      drawUDPLine();
    }
  }
  if (525-mouseY < 3 && 525-mouseY > 0) mousePressed = false; //Attempts to prevent accidental button presses
  if (mousePressed) {
    stroke(c);
    strokeWeight(s);
    if (mouseY > 525 && mouseX < 278 && mouseX > 0 && mouseY < 600) c = get(mouseX, mouseY); //Change color
    else if (mouseX >= 297.5 && mouseX <= 322.5 && mouseY >= 553 && mouseY <= 578 && s > 1) s = s - 0.2; //Shrink
    else if (mouseX >= 407.5 && mouseX <= 432.5 && mouseY >= 553 && mouseY <= 578) s = s + 0.2; //Grow
    else if (mouseX >= 452 && mouseX <= 502 && mouseY >= 540 && mouseY <= 600) c = color(55); //Eraser
    else if (mouseX >= 505 && mouseX <= 555  && mouseY >= 540 && mouseY <= 600) {
      if (mc){
        if(javax.swing.JOptionPane.showConfirmDialog(
        frame, 
        "Are you sure you want to delete this shared canvas,\n this will affect all users on multicast!", 
        "Are you sure?", 
        javax.swing.JOptionPane.YES_NO_OPTION, 
        javax.swing.JOptionPane.WARNING_MESSAGE) == 0) udp.send("clear");
      }
      else clearScreen(false);
      mousePressed = false;
    }
    else if (mouseX >= 558 && mouseX <= 608  && mouseY >= 540 && mouseY <= 600) { //Save
      mousePressed = false; 
      selectOutput("Select a file to write to:", "savePick");
    }
    else if (mouseX >= 611 && mouseX <= 661  && mouseY >= 540 && mouseY <= 600) { //Open: Turn loop off for stability
      if (keyPressed && key == 'f') backImport = false;
      if (keyPressed && key == 'b') backImport = true;
      mousePressed = false;
      if (!mc) { 
        selectInput("Select image to load:", "fileSelected");
      }
      else {
        if (javax.swing.JOptionPane.showConfirmDialog(
        frame, 
        "Images added in multicast sessions can add some issues.\n A new user to the session may recieve a corrupted canvas!\n Do you want to attempt an import?", 
        "Multicast Alert", 
        javax.swing.JOptionPane.YES_NO_OPTION, 
        javax.swing.JOptionPane.WARNING_MESSAGE) == 0)   selectInput("Select image to load:", "fileSelected");
      }
    }
    else if (mouseX >= 664 && mouseX <= 714 && mouseY >= 540 && mouseY <= 600) { 
      mousePressed = false; 
      if (mc) udp.send("r");
      else randomize();
    } 
    else if (mouseX >= 715 && mouseX <= 765 && mouseY >= 540 && mouseY <= 600) { 
      if (mc) mc = false;
      else {
        clearScreen(true);
        mc = true;
        udp.send("needcanvas");
        canvasWaiting = true;
        waiting = frameCount;
      }
      mousePressed = false;
    } 
    else {
      line(pmouseX, pmouseY, mouseX, mouseY);
      sendPacket(); //Send the line packet
    }
  }
  if (newimg) { //Is there a non export image waiting
    if (mousePressed) { //Has a location been picked
      imageMode(CENTER);
      image(load, mouseX, mouseY);
      load = null;
      newimg = false;
    }
    else if (keyPressed && key == BACKSPACE) { //Should we exit out?
      load = null; 
      newimg = false;
    }
    else { //Display prompt text
      noStroke();
      fill(81, 81, 81);
      rect(0, 525, 800, 75);
      textAlign(CENTER);
      fill(245);
      if (backImport) text("Click a location to place your image (Background Importing not supported for this image)", 400, 565.5);
      else text("Click a location to place your image", 400, 565.5);
    }
  }
  else sketchBase();
  if (canvasSent != 0) sendCanvas();
}
void sketchBase() {
  //Basic Shape
  noStroke();
  fill(81, 81, 81);
  rect(0, 525, 800, 75);
  //Color gradient
  imageMode(CORNER);
  image(g, 0, 525, 278, 157);
  //Shrink Button
  fill(35);
  rectMode(CENTER);
  rect(310, 565.5, 25, 25);
  textAlign(CENTER);
  fill(230);
  textSize(15);
  text("-", 310, 570);
  //Brush visuilization 
  fill(c);
  ellipseMode(CENTER);
  if (c != color(55)) {
    if (s > 65) ellipse(365, 565.5, 65, 65);
    else ellipse(365, 565.5, s, s);
  }
  else { //Display Eraser
    noFill();
    stroke(245);
    strokeWeight(2);
    if (s > 65) ellipse(365, 565.5, 65, 65);
    else ellipse(365, 565.5, s, s);
  }
  //Grow button
  fill(35);
  noStroke();
  rect(420, 565.5, 25, 25);
  fill(230);
  text("+", 421, 570);
  fill(125);
  //Toolbox background
  rectMode(CORNER);
  rect(452, 525, 348, 75);
  //Icons
  image(erase, 465, 542.5, 35, 35);
  image(clear, 515, 542.5, 35, 35);
  image(save, 565, 542.5, 35, 35);
  image(open, 615, 542.5, 35, 35);
  image(random, 665, 542.5, 35, 35);
  image(wifi, 715, 542.5, 35, 35);
  if (mc) fill(133, 170, 0);
  else fill(220, 50, 47);
  rect(715, 580, 35, 5);
  if (canvasSent != 0 && mc) {
    fill(0);
    rect(715, 580, map(canvasSent, 0, 420000, 0, 35), 5);
  }
  if (canvasGot != 0 && mc && canvasWaiting) {
    fill(0);
    rect(715, 580, map(canvasGot, 0, 420000, 0, 35), 5);
  }
}
void clearScreen(Boolean force) { //Clears out the screen
if(force){
   background(55);
  sketchBase();
  mousePressed = false;
  canvasWaiting = false;
  waiting = 0;
  canvasGot = 0;
  canvasSent = 0;
}
 else if (javax.swing.JOptionPane.showConfirmDialog(
        frame, 
        "Are you sure you want to delete the canvas?", 
        "Are you sure?", 
        javax.swing.JOptionPane.YES_NO_OPTION, 
        javax.swing.JOptionPane.WARNING_MESSAGE) == 0) {
  background(55);
  sketchBase();
  mousePressed = false;
  canvasWaiting = false;
  waiting = 0;
  canvasGot = 0;
  canvasSent = 0;
        }
}

void Save() { //Saves pixels into new file
  PImage file;
  loadPixels();
  file = createImage(800, 525, RGB);
  file.loadPixels();
  for (int i = 0; i < 420000; i++) file.pixels[i] = pixels[i];
  file.updatePixels();
  file.save(savepath);
  println("saved!");
  mousePressed = false;
}
void fileSelected(File selection) { //Open handler
  if (selection == null) {
    println("No file selected.");
  } 
  else {
    String path = selection.getAbsolutePath();
    println("Processing import of " + path);
    load = loadImage(path);
    load.loadPixels();
    if (load.pixels.length != 420000 || !path.substring(path.length()-3).equals("png")) {
      println("Import cancelled, file must be exported by application");
      newimg = true;
    }
  }
}
void transferImage(PImage img) { //Standard image importer
  //Prepare Pixels
  loadPixels();
  img.loadPixels();
  for (int i = 0; i < img.pixels.length; i++) {
    if (img.pixels[i] == color(55)) continue; //Pixel should be transparent
    if (pixels[i] != color(55) && backImport) continue; //We are shifting to back
    pixels[i] = img.pixels[i];
  }
  updatePixels();
}
void savePick(File selection) { //Save Handler
  if (selection == null)  println("No file selected.");
  else {
    String path = selection.getAbsolutePath();
    println("Processing save to " + path);
    if (!path.substring(path.length()-3).equals("png"))println("Only .png saving is supported at this time.");
    else savepath = selection.getAbsolutePath();
  }
}
void randomize() { //Pixel randomizer
  loadPixels();
  for (int i = 0; i < 420000; i++) {
    if (pixels[i] == color(55)) continue;
    pixels[i] = color(Math.round(random(red(pixels[i]))), Math.round(random(green(pixels[i]))), Math.round(random(blue(pixels[i]))));
  }
  updatePixels();
}
void sendPacket() { //Draw line packet sender
  if (!mc) return;
  udp.send(mouseX + " " + mouseY + " " + pmouseX + " " + pmouseY + " " + s + " " + c);
}
void receive( byte[] data ) { //UDP data reciever
  if (!mc) return;
  UDPline.add(new String(data).split(" "));
}
void drawUDPLine() { //Processes packet off packet list
  String[] str = UDPline.get(0);
  UDPline.remove(0);
  if (str[0] == null) return;
  println(str);
  if (str[0].equals("clear")) clearScreen(true);
  else if (str[0].equals("needcanvas")) sendCanvas();
  else if (str[0].equals("c")) recieveCanvas(str);
  else if (str[0].equals("r")) randomize();
  else {
    stroke(Integer.parseInt(str[5]));
    strokeWeight(Float.parseFloat(str[4]));
    line(Float.parseFloat(str[2] + ".0"), Float.parseFloat(str[3] + ".0"), Float.parseFloat(str[0] + ".0"), Float.parseFloat(str[1] + ".0"));
  }
}
void loadSketch() { //Runs setup on first frame 
  udpConnect();
  g = loadImage("photo.JPG");
  open = loadImage("open.png");
  erase = loadImage("erase.png");
  clear = loadImage("clear.png");
  save = loadImage("floppy.png");
  random = loadImage("random.png");
  wifi = loadImage("wifi.png");
  background(55);
}
void udpConnect() { 
  udp = new UDP( this, 6000, "224.0.0.1" );
  udp.listen(true);
}
void recieveCanvas(String[] str) { //Canvas multicast reciever
  if (!canvasWaiting) return;
  loadPixels();
  waiting = -10;
  canvasGot = Integer.parseInt(str[1]);
  for (int i = 2; i < str.length; i++) {
    pixels[Integer.parseInt(str[1])+i-2] = Integer.parseInt(str[i]);
  }
  updatePixels();
  if (Integer.parseInt(str[1]) == 420000-200) {

    canvasWaiting = false;
    waiting = 0;
    canvasGot = 0;
  }
}
void sendCanvas() { //Canvas pixel sender
  if (canvasWaiting) return;
  loadPixels();
  Boolean blank = true;
  String data = "";
  for (int j = 0; j <= 200; j++) {
    data = data + pixels[canvasSent+j] + " ";
    if (pixels[canvasSent+j] != color(55)) blank = false;
  }
  if (!blank || canvasSent == 420000-200 || canvasSent == 0) {
    udp.send("c " + canvasSent + " " + data);
  }
  if (canvasSent == 420000-200) {
    canvasSent = 0;
  }
  else canvasSent += 200;
}

