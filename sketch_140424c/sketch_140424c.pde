String[] data;
Line[] lines;
void setup() {
  size(800, 600);
  data = loadStrings("http://www.gutenberg.org/cache/epub/1120/pg1120.txt");
  lines = new Line[data.length];
  for(int i = 0; i < data.length; i++) if(data[i].length() > 2) lines[i] = new Line(data[i]);
}
void draw(){
  background(135);
  for(Line l : lines) if(l != null) l.render();
}
