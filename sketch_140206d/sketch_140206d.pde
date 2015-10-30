void setup(){
  size(500,500);
}
int data = 52725;
int one;
int two;
int three;
void draw(){
  stroke(255);
background(51);
colorMode(RGB,data,data,data);
one = data - Math.round(random(data));
two = data - one - Math.round(random(data - one));
three = data - one - two - Math.round(random(data-one-two));
color from = color(one, two, three);
color to = color(0, 0, 0);
color interA = lerpColor(from, to, .33);
color interB = lerpColor(from, to, .66);
fill(from);
rect(50, 25, 100, 450);
fill(interA);
rect(150, 25, 100, 450);
fill(interB);
rect(250, 25, 100, 450);
fill(to);
rect(350, 25, 100, 450);
}
