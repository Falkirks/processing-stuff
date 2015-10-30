void setup() {
size(1000, 1000, P3D);
noStroke();
translate(500, 500, 0);
color(1);
sphere(10);
println("Controls:");
println("wasd - Move blob:");
println("c - Clear the screen");
println("n - Spawn a new blob without clearing old");
println("SPACE - Pause growth (still generates)");
}
 int pulse = 10;
 int x = 500;
 int y = 500;
 int z = 0;
 int t = 2;
 int pause = 0;
void draw() {
    if (keyPressed == true && key != 'p'){
    if(key == 'n'){
    pulse = 10;
    z++;
    }
   else if(key == 'w'){
    y--;
    }
    else if(key == 's'){
    y++;
    }
    else if(key == 'd'){
    x++;
    }
   else if(key == 'a'){
    x--;
    }
    else{
    }
    }
    if(pause != 1){
  noStroke();
translate(x, y,z);
stroke(abs(mouseY)/5, abs(mouseX)/5,height);
noFill();
lights();
sphere(pulse);
pulse++;
    }
    else{
        noStroke();
translate(x, y,z);
stroke(abs(mouseY)/5, abs(mouseX)/5,height);
noFill();
lights();
sphere(pulse);
    }

  }
 void keyPressed() {
  if(key == ' '){
          if(pause == 1){
        pause = 0;
      }
      else{
        pause = 1;
      }
    }
          else if(key == 'c'){
    background(0);
    pulse = 10;
    x = 500;
    y = 500;
      }
}
  
