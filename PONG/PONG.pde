Ball ball;
Paddle p1;
Paddle p2;
int xSpeed = 5; //Magnitude for ball xSpeed
Boolean paused = false;
void setup() {
  size(800, 600);
  ball = new Ball();
  p1 = new Paddle();
  p2 = new Paddle();
}
void draw() {
  background(155);
  checkKeys();
  if (!paused) {
    p1.move();
    p2.move();
    ball.update();
  }
  drawGame();
  drawInterface();
}

void keyPressed() {
  //P1 Controls
  if (key == 'p') paused = !paused;
  if (!paused) {
    if (key == 'w' || key == 'W') p1.up = true;
    if (key == 's' || key == 'S') p1.down = true;

    //P2 Controls
    if (key == 'i' || key == 'I') p2.up = true;
    if (key == 'k' || key == 'K') p2.down = true;
  }
}
void keyReleased() {
  //P1 Controls
  if (key == 'w' || key == 'W') p1.up = false;
  if (key == 's' || key == 'S') p1.down = false;

  //P2 Controls
  if (key == 'i' || key == 'I') p2.up = false;
  if (key == 'k' || key == 'K') p2.down = false;
}
void drawGame() {
  fill(0);
  ellipseMode(CENTER);
  ellipse(ball.x, ball.y, 20, 20);
  rectMode(CENTER);
  rect(50, p1.y, 10, p1.size);
  rect(width-50, p2.y, 10, p2.size);
}
void drawInterface() {
  for (int i = 0; i < height; i += 20) {
    strokeWeight(5);
    line(width/2, i, width/2, i+10);
  }
  textSize(40);
  fill(0);
  textAlign(CENTER);
  text(p1.score, width/4, 100);
  text(p2.score, width-width/4, 100);
}
void resetGame() {
  ball = new Ball();
  p1 = new Paddle();
  p2 = new Paddle();
}
void checkKeys() {
  if (keyPressed && key == ' ') ball.start(xSpeed);
  if (keyPressed && key == 'r') resetGame();
}

