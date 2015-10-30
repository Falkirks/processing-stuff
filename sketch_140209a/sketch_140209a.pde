void setup() {
  selectFolder("Select your Processing Folder:", "folderSelected");
  size(1000,900);
  logo = loadImage("logo.png");
  baseUI();
  textAlign(CENTER);
  textSize(32);
  fill(255);
  text("Loading...",width/2,height/2);
}
File[] files;
PImage logo;
int failed = 0;
void draw(){
  if(failed == 1){
    baseUI();
    textAlign(CENTER);
  textSize(32);
  fill(255);
  text("Process aborted!",width/2,height/2);
  }
}
void folderSelected(File selection) {
  if (selection == null) {
failed = 1;
  } else {
    files = new File(selection.getAbsolutePath()).listFiles();
    loadFiles(files);
    
  }
}
void loadFiles(File[] files) {
    for (File file : files) {
        if (file.isDirectory()) {
       if(file.getName() == "tools"){
         println("hello");
       }
       else{
         println(file.getName());
       }
          }
         else {
            System.out.println("File: " + file.getName());
             
        }
    }
}

void baseUI(){
  background(200);
 noStroke();

 // image(img,0,0,width,height);
    fill(50,50,50,85);
  rect(50,50,900,800);
  imageMode(CENTER);
  image(logo,width/2,75,100,100);
}
