color c = color(55); //Current color
float s = 10; //Brush size
PImage g; //Color Gradient
PImage open; //Open icon
PImage erase; //Eraser icon
PImage clear; //Clear icon
PImage save; //Save icon
PImage random; //Random icon
PImage load; //Storage for image imports
String savepath; //Current save path
Boolean backImport = true; //When set to true image imports will be sent to back
Boolean newimg = false; //Current importing image is not an exported image
void setup() {
  size(800, 600, P2D);
  background(55);
  g = loadImage("photo.JPG");
  open = loadImage("open.png");
  erase = loadImage("erase.png");
  clear = loadImage("clear.png");
  save = loadImage("floppy.png");
  random = loadImage("random.png");
}
void draw() {
  if (savepath != null) { //Is there a save waiting?
    Save(); 
    savepath = null;
  }
  if (load != null && !newimg) { //Is there an import waiting, but not another image/
    transferImage(load); 
    load = null;
  }
  if (525-mouseY < 3 && 525-mouseY > 0) mousePressed = false; //Attempts to prevent accidental button presses
  if (mousePressed) {
    stroke(c);
    strokeWeight(s);
    if (mouseY > 525 && mouseX < 278 && mouseX > 0 && mouseY < 600) c = get(mouseX, mouseY); //Change color
    else if (mouseX >= 297.5 && mouseX <= 322.5 && mouseY >= 553 && mouseY <= 578 && s > 1) s = s - 0.2; //Shrink
    else if (mouseX >= 407.5 && mouseX <= 432.5 && mouseY >= 553 && mouseY <= 578) s = s + 0.2; //Grow
    else if (mouseX >= 452 && mouseX <= 502 && mouseY >= 540 && mouseY <= 600) c = color(55); //Eraser
    else if (mouseX >= 505 && mouseX <= 555  && mouseY >= 540 && mouseY <= 600) clearScreen(); //Clear
    else if (mouseX >= 558 && mouseX <= 608  && mouseY >= 540 && mouseY <= 600) { //Save
      mousePressed = false; 
      selectOutput("Select a file to write to:", "savePick");
    }
    else if (mouseX >= 611 && mouseX <= 661  && mouseY >= 540 && mouseY <= 600) { //Open: Turn loop off for stability
      if (keyPressed && key == 'f') backImport = false;
      if (keyPressed && key == 'b') backImport = true;
      noLoop(); 
      selectInput("Select image to load:", "fileSelected");
    }
    else if (mouseX >= 664 && mouseX <= 714 && mouseY >= 540 && mouseY <= 600) { 
      mousePressed = false; 
      randomize();
    } 
    else line(pmouseX, pmouseY, mouseX, mouseY);
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
}
void clearScreen() { //Clears out the screen
  background(55);
  sketchBase();
}

void Save() { //Saves pixels into new file
  PImage file;
  loadPixels();
  file = createImage(800, 525, RGB);
  file.loadPixels();
  for (int i = 0; i < 420000; i++) {
    file.pixels[i] = pixels[i];
  }
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
  loop();
  mousePressed = false; //Prevents user from clicking again
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
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } 
  else {
    String path = selection.getAbsolutePath();
    println("Processing save to " + path);
    if (!path.substring(path.length()-3).equals("png"))println("Only .png saving is supported at this time.");
    else savepath = selection.getAbsolutePath();
  }
}
void randomize() {
  loadPixels();
  for (int i = 0; i < 420000; i++) {
    if (pixels[i] == color(55)) continue;
    pixels[i] = color(Math.round(random(red(pixels[i]))), Math.round(random(green(pixels[i]))), Math.round(random(blue(pixels[i]))));
  }
  updatePixels();
}

