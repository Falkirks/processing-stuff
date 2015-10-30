int percent = 0;
Boolean up = true;
void setup(){
  size(800, 600);
  colorMode(HSB, 360, 100, 100, 100);
}
 
void draw(){
    background(360 * (float) percent/1200, 100, 100, 100);
    if(up) percent++;
    else percent--;
    if(percent > 1200 || percent < 1) up = !up;
}
 

