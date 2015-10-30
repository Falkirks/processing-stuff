Ball ball;
Paddle p1;
Paddle p2;
Player p;
sBall sball;
int xSpeed = 5; //Magnitude for ball xSpeed
Boolean paused = false;
Boolean gamePlaying = false;
Boolean aiPlaying = false;
int percent = 0;
void setup() {
  size(800, 600);
  ball = new Ball();
  p1 = new Paddle();
  p2 = new Paddle();
  p = new Player();
  sball = new sBall();
}
void draw() {
  background(7, 54, 66);
  checkKeys();
  if (gamePlaying) {
    if (!paused) {
      if (aiPlaying) p.think();
      p2.move();
      p1.move();
      ball.update();
    }
    drawInterface();
    drawGame();
  }
  else drawStartScreen();
}

void keyPressed() {
  //P1 Controls
  if (key == 'p') paused = !paused;
  if (!paused) {
    if (key == 'w' || key == 'W') p1.up = true;
    if (key == 's' || key == 'S') p1.down = true;

    //P2 Controls
    if (!aiPlaying) {
      if (key == 'i' || key == 'I') p2.up = true;
      if (key == 'k' || key == 'K') p2.down = true;
    }
  }
}
void keyReleased() {
  //P1 Controls
  if (key == 'w' || key == 'W') p1.up = false;
  if (key == 's' || key == 'S') p1.down = false;

  //P2 Controls
  if (!aiPlaying) {
    if (key == 'i' || key == 'I') p2.up = false;
    if (key == 'k' || key == 'K') p2.down = false;
  }
}
void drawGame() {
  noStroke();
  ellipseMode(CENTER);
  fill(38, 139, 210);
  ellipse(ball.x, ball.y, 20, 20);
  rectMode(CENTER);
  fill(131, 148, 150);
  rect(50, p1.y, 10, p1.size);
  rect(width-50, p2.y, 10, p2.size);
}
void drawInterface() {
  stroke(101, 123, 131);
  for (int i = 0; i < height; i += 20) {
    strokeWeight(5);
    line(width/2, i, width/2, i+10);
  }
  textSize(55);
  textAlign(CENTER);
  if (p1.score != p2.score) {
    if (p1.score > p2.score) {
      fill(181, 137, 0);
      text(p1.score, width/4, 100);
      fill(101, 123, 131);
      text(p2.score, width-width/4, 100);
    }
    else {
      fill(101, 123, 131);
      text(p1.score, width/4, 100);
      fill(181, 137, 0);
      text(p2.score, width-width/4, 100);
    }
  }
  else {
    fill(101, 123, 131);
    text(p1.score, width/4, 100);
    text(p2.score, width-width/4, 100);
  }
}
void resetGame() {
  ball = new Ball();
  p1 = new Paddle();
  p2 = new Paddle();
}
void checkKeys() {
  if (keyPressed && key == ' ') ball.start(xSpeed);
  if (keyPressed && key == 'r') resetGame();
  if (keyPressed && key == BACKSPACE) {
    resetGame();
    gamePlaying = false;
    aiPlaying = false;
  }
}
void drawStartScreen() {
  background(0, 43, 54);
  textSize(85);
  textAlign(CENTER);
  fill(235);
  text("PONG", width/2, height/2-100);
  rectMode(CORNER);
  fill(7, 54, 66);
  rect(150, height/2, 200, 75);
  rect(450, height/2, 200, 75);
  rectMode(CENTER);
  rect(width/2, height/2+150, 200, 75);
  textSize(20);
  fill(147, 161, 161);
  text("Single Player", 250, height/2+(75/2));
  text("Two Player", 550, height/2+(75/2));
  text("Online Multiplayer", width/2, height/2+150);
  if (mousePressed) {
    println(mouseX + " " + mouseY);
    if (mouseY >= height/2 && mouseY <= height/2+75) {
      if (mouseX >= 150 && mouseX <= 350) {
        gamePlaying = true;
        aiPlaying = true;
      }
      if (mouseX >= 450 && mouseX <= 750) gamePlaying = true;
    }
    if (mouseY >= height/2+150-(75/2) && mouseY <= height/2+150+(75/2) && mouseX >= width/2-100 && mouseX <= width/2+100 ) println("Multiplayer not yet implemented");
  }
  sball.render();
}

