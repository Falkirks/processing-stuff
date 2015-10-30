ball ball;
paddle p1;
paddle p2;
void setup(){
  size(800,600);
  ball = new ball();
  p1 = new paddle();
  p2 = new paddle();
  
}
void draw(){
  background(155);
  if(keyPressed && key == ' ') ball.start();
  p1.move();
  p2.move();
  ball.update();
  checkCollisions();
  fill(0);
  ellipseMode(CENTER);
  ellipse(ball.x,ball.y,20,20);
  rectMode(CENTER);
  rect(50,p1.y,10,p1.size);
  rect(width-50,p2.y,10,p2.size);
  
}
void checkCollisions(){
  //Back wall collisions 
  if(ball.x+10 > 800){
    ball.reset();
    p1.score++;
  }
    if(ball.x-10 < 0){
    ball.reset();
    p2.score++;
  }
 
 // if(ball.x ) ball.collide();
  
}
void keyPressed(){
  //P1 Controls
  if(key == 'w') p1.up = true;
  if(key == 's') p1.down = true;
  
  //P2 Controls
  if(key == 'i') p2.up = true;
  if(key == 'k') p2.down = true;
}
void keyReleased(){
  //P1 Controls
  if(key == 'w') p1.up = false;
  if(key == 's') p1.down = false;
  
  //P2 Controls
  if(key == 'i') p2.up = false;
  if(key == 'k') p2.down = false;
}

