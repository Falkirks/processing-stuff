String[] data;
Line[] lines;
void setup() {
  size(800, 600);
  data = loadStrings("http://eremita.di.uminho.pt/gutenberg/etext97/1ws2410.txt");
  lines = new Line[data.length];
  for (int i = 100; i < data.length; i++) if (data[i].length() > 2) lines[i] = new Line(data[i]);
}
void draw() {
  if (!keyPressed) {
    background(135);
    for (Line l : lines) if (l != null) l.render();
  }
  else {
    if (key == 'r') {
      for (int i = 100; i < data.length; i++) if (data[i].length() > 2) lines[i] = new Line(data[i]);
    }
  }
}

