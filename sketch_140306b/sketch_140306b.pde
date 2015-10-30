/*
Cool Spider (Processing - PHP - JQuery)
A super simple web spider that will do awesome stuff!
http://(?:(?!http://).)*
*/
StringList pool = new StringList();
String seed = "http://wikipedia.org";
String[] raw;
String[][] m;

void setup(){
  pool.append(seed); //Add the magic seed
}
void draw(){
  for(String url : pool){
      raw = loadStrings(url);
      if(raw == null){
        println("Error fetching: " + url);
        continue;
      }
      m = matchAll(join(raw, " "), "http://(?:(?!http://).)*");
      for (int i = 0; i < m.length; i++) {
  println("Found '" + m[i][0] + "' inside a tag.");
}
  }
}



