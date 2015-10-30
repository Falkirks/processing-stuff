String strNum = "false"; //Credit card number 45639601522001999
int Sum = 0; //Check Sum
int digit; //Digit Iteration
int tick = 0; //Odd or Even
String ssum;
void setup(){
  size(500,500,P2D);
}
void draw(){
for (int i = 0; i < strNum.length(); i++) {
digit = Character.getNumericValue(strNum.charAt(i));
if(tick == 0){
  tick = 1;
  if(digit > 4){
  ssum = Integer.toString(digit*2);
Sum = Sum + Character.getNumericValue(ssum.charAt(0)) + Character.getNumericValue(ssum.charAt(1));
  }
  else{
    Sum = Sum + (digit*2);
  }
}
else{
  tick = 0;
  Sum = Sum + digit;
}
}
if(strNum == "false"){
  background(0);
  textSize(25);
textAlign(CENTER);
fill(255);
text("Type credit card number...",250,250);
}
else{
if(Sum % 10 == 0){
//println("You passed LUHN with " + Sum);
background(0,255,0);
textSize(75);
textAlign(CENTER);
fill(25);
text(Sum,250,250);
}
else{
  //println("You failed LUHN with " + Sum);
  background(255,0,0);
  textSize(75);
textAlign(CENTER);
fill(25);
text(Sum,250,250);
}
}
Sum = 0;
tick = 0;
}
void keyPressed() {
  if(strNum != "false"){
  strNum = strNum + key;
  println(strNum);
  }
  else{
    strNum = key + "";
  }
}
