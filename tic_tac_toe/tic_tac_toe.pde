int[] board = new int[] {0, 0, 0, 0, 0, 0, 0, 0, 0};
int[] test = new int[9];
int[][] lines = new int[8][3];
Boolean toMove;
Boolean hasWon = false;
Boolean isDraw = false;
Boolean firstMove;
void setup() {
  generateLines();
if(random(0,100) > 50){
  toMove = false;
  firstMove = true;
}
else{
  toMove = true;
  firstMove = false;
}
    size(500, 500);
  println("Welcome to tic-tac-toe");
  println("Note: Perfect players should only be able to win or draw");
}
void draw() {
   background(0,43,54);
  if(frameCount < 75){
   textAlign(CENTER);
   fill(225);
   textSize(32);
  text("Perfect Player tic-tac-toe",250,250);
  textSize(25);
  fill(125);
  text("By: ***REMOVED***",250,270);
  return;
  }
  if (toMove) calculateMove();
  checkDraw();
  int x = 100;
  int y = 100;
  rectMode(CORNER);
  for (int i = 0; i < board.length; i++) {
    if (board[i] == 10) fill(139, 210, 205);
    else if (board[i] == 1) fill(220, 50, 47);
    else fill(7,54,66);
    stroke(88,110,117);
    strokeWeight(5);
    rect(x, y, 100, 100);
    x += 100;
    if (x % 400 == 0) { 
      y += 100;
      x = 100;
    }
  }
    if(hasWon) drawWin();
    if(isDraw) drawDraw();
}
int[][] calculateBoard(int[] in) {
  int[][] work =  new int[8][3];
  int i = 0;
  for (int[] line: lines) {
    work[i][0] = in[lines[i][0]];
    work[i][1] = in[lines[i][1]];
    work[i][2] = in[lines[i][2]];
    i++;
  }
  return work;
}
void mousePressed() {
  if(hasWon || isDraw){
    //Reset the match
    hasWon = false;
    isDraw = false;
    board = new int[] {0, 0, 0, 0, 0, 0, 0, 0, 0};
    if(random(0,100) > 50){
      toMove = false;
      firstMove = true;
    }
    else toMove = true;
    
  }
  if (!toMove && !isDraw && !hasWon) {
    int y = floor(mouseY/100);
    int x = floor(mouseX/100);
    int i;
    //println(y);
    //println(x);
    if (x == 1) { //First
      if (y == 1) i = 0;
      else if (y == 2) i = 3;
      else if (y == 3) i = 6;
      else return;
    }
    else if (x == 2) { //Second
      if (y == 1) i = 1;
      else if (y == 2) i = 4;
      else if (y == 3) i = 7;
      else return;
    }
    else if (x == 3) {
      if (y == 1) i = 2;
      else if (y == 2) i = 5;
      else if (y == 3) i = 8;
      else return;
    }
    else {
      return;
    }
    //println(i);
    if (board[i] == 0) {
      toMove = true;
      board[i] = 1;
    }
  }
}
void calculateMove() {
  int[][] data = calculateBoard(board);
  if(firstMove){ //Prevent double fork on first move
    firstMove = false;
     if(board[0] == 0 && board[8] == 1){
     board[0] = 10;
        toMove = false;
        return;
 }
  if(board[8] == 0 && board[0] == 1){
     board[8] = 10;
        toMove = false;
        return;
 }
  if(board[2] == 0 && board[6] == 1){
     board[2] = 10;
        toMove = false;
        return;
 }
  if(board[6] == 0 && board[2] == 1){
     board[6] = 10;
        toMove = false;
        return;
 }
  }
  //WINS
  for (int i = 0; i < data.length; i++) {
    if(data[i][0] + data[i][1] + data[i][2] == 20){ //We have found a possible win
      if(data[i][0] == 0) board[lines[i][0]] = 10;
      else if(data[i][1] == 0) board[lines[i][1]] = 10;
      else board[lines[i][2]] = 10;
      toMove = false;
      hasWon = true;
      return;
    }
  }
  //LOSES
    for (int i = 0; i < data.length; i++) { //Calculate possible losses
    if(data[i][0] + data[i][1] + data[i][2] == 2){ //We have found a possible loss
      if(data[i][0] == 0) board[lines[i][0]] = 10;
      else if(data[i][1] == 0) board[lines[i][1]] = 10;
      else board[lines[i][2]] = 10;
      toMove = false;
      return;
    }
  }
  
 
//FORK
  for(int i = 0; i < board.length; i++){
    if(board[i] == 0){
       test = board.clone();
      int c = 0;
      test[i] = 10;
      data = calculateBoard(test);
    for (int j = 0; j < data.length; j++) {
    if(data[j][0] + data[j][1] + data[j][2] == 20) c++;
  }
        if(c == 2){
          board[i] = 10;
        toMove = false;
        return;
        }
    }
  }
  //FIND FORKS
  //TODO: Add option 1 strategy
    for(int i = 0; i < board.length; i++){
    if(test[i] == 0){
       test = board.clone();
      int c = 0;
      test[i] = 1;
      data = calculateBoard(test);
    for (int j = 0; j < data.length; j++) {
    if(data[j][0] + data[j][1] + data[j][2] == 2) c++;
  }
        if(c > 1){
          board[i] = 10;
        toMove = false;
        return;
        }
    }
  }
  //Mark center
 if(board[4] == 0){
      board[4] = 10;
        toMove = false;
        return;
 }
 //Opposite corners
 if(board[0] == 0 && board[8] == 1){
     board[0] = 10;
        toMove = false;
        return;
 }
  if(board[8] == 0 && board[0] == 1){
     board[8] = 10;
        toMove = false;
        return;
 }
  if(board[2] == 0 && board[6] == 1){
     board[2] = 10;
        toMove = false;
        return;
 }
  if(board[6] == 0 && board[2] == 1){
     board[6] = 10;
        toMove = false;
        return;
 }
 //Any corner and any side
 if(board[0] == 0) board[0] = 10;
 else if(board[2] == 0) board[2] = 10;
 else if(board[6] == 0) board[6] = 10;
 else if(board[8] == 0) board[8] = 10;
 else {
   for(int k = 0; k < board.length; k++){
     if(board[k] == 0){
       board[k] = 10;
        toMove = false;
        return;
     }
   }
   isDraw = true;
   
 }
  toMove = false; 
}
void generateLines() {
  //H
  lines[0][0] = 0;
  lines[0][1] = 1;
  lines[0][2] = 2;

  lines[1][0] = 3;
  lines[1][1] = 4;
  lines[1][2] = 5;

  lines[2][0] = 6;
  lines[2][1] = 7;
  lines[2][2] = 8;

  //V
  lines[3][0] = 0;
  lines[3][1] = 3;
  lines[3][2] = 6;

  lines[4][0] = 1;
  lines[4][1] = 4;
  lines[4][2] = 7;

  lines[5][0] = 2;
  lines[5][1] = 5;
  lines[5][2] = 8;

  //D
  lines[6][0] = 0;
  lines[6][1] = 4;
  lines[6][2] = 8;

  lines[7][0] = 6;
  lines[7][1] = 4;
  lines[7][2] = 2;
}
void drawWin(){
  noStroke();
   fill(7,54,66);
  rectMode(CENTER);
  rect(250,475,500,75);
  textAlign(CENTER);
    fill(131,148,150);
  textSize(27);
  text("You lost!",250,465);
  textSize(15);
  text("Click to reset.",250,480);
}
void drawDraw(){
  noStroke();
  fill(7,54,66);
  rectMode(CENTER);
  rect(250,475,500,75);
  textAlign(CENTER);
 fill(131,148,150);
  textSize(27);
  text("Draw...",250,465);
    textSize(15);
  text("Click to reset.",250,480);
}
void checkDraw(){
    Boolean draw = true;
    for(int i : board){
      if(i == 0){
        draw = false;
      }
    }
    if(draw) isDraw = true;
}
