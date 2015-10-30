String a = "";
String b = "";
Boolean aset = false;
float grade = 0;
void setup(){
  println("Press ENTER to advance to the next denominator and then to calculate, If screen resets to default an error was encountered in calculation.");
  size(500,500);
  background(0);
}
void draw(){
  background(0);
  textAlign(CENTER);
  text(a + "/" + b,width/2,450);
  textAlign(CENTER);
if(grade >= 86){
  text("A | " + grade + "%",width/2,height/2);
}
else if(grade >= 73){
  text("B | " + grade + "%",width/2,height/2);
}
else if(grade >= 67){
 text("C+ | " + grade + "%",width/2,height/2);
}
else if(grade  >= 60){
 text("C | " + grade + "%",width/2,height/2);
}
else if(grade >= 50){
  text("C- | " + grade + "%",width/2,height/2);
}
else{
  text("Fail/Incomplete | " + grade ,width/2,height/2);
}
}
void keyPressed(){
  if(isKey()){
  if(aset){
    if(key == ENTER || key == RETURN){
      if(b != "" && a != ""){
      if(Float.parseFloat(b) == 0){
        b = "";
        a = "";
        aset = false;
      }
      else{
        
        grade = (Float.parseFloat(a)/Float.parseFloat(b))*100;
        
         b = "";
        a = "";
        aset = false;
      }
      }
      else{
        b = "";
        a = "";
        aset = false;
      }
    }
       else if(key == BACKSPACE){
      b = b.substring(0,b.length()-1);
    }
    else{
       if(key == '.' && b.indexOf('.') != -1){
        //Duplicate Decimal Point
      }
      else{
      b = b + key;
      }
    }
    
  }
  else{
    if(key == ENTER || key == RETURN){
      aset = true;
    }
    else if(key == BACKSPACE){
      a = a.substring(0,a.length()-1);
    }
    else{
      if(key == '.' && a.indexOf('.') != -1){
        //Duplicate Decimal Point
      }
      else{
      a = a + key;
      }
    }
  }
}
}
Boolean isKey(){ //Check if new Char is good for fraction
  if(key == BACKSPACE || key == RETURN || key == ENTER || key == '.'){
    return true;
  }
  try{
    Integer.parseInt(key + "");
  }
  catch (Exception ex) {
    return false;
  }
  return true;
}
