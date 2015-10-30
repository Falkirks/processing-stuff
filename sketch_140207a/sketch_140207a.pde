void setup(){
  String url = "http://en.wikipedia.org/w/api.php?action=query&list=recentchanges&format=xml&rclimit=10&rctype=edit";
  String[] raw = loadStrings(url);
  link("http://google.com");
  String all = join(raw, " ");
  XML xml = parseXML(all);
  xml = xml.getChild("query").getChild("recentchanges");
 
   XML[] children = xml.getChildren("rc");
  for (int i = 0; i < children.length; i++) {

    println(children[i].getString("title"));
    link("http://en.wikipedia.org/w/index.php?title=" + children[i].getString("title").replace(" ","_") + "&diff=" + children[i].getString("revid") + "&oldid=" + children[i].getString("old_revid"));
  }
 
}
