import processing.serial.*;
void setup(){
  for(String serial : Serial.list()){
    println(serial);
  }
}
