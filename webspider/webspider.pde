/*
Web Spider (Processing)
A simple web spider to find a lot of unique links from a seed! Links can't be crawled twice.
This spider will only match http protocol links prefixed by http:// or //
The seed will only be allowed to appear once in the result to prevent a continous loop.
*/
PrintWriter output;
StringList pool = new StringList(); //URL lineup
String seed = "http://forum.minepocket.com/index.php"; //This is the URL where the Spider will start, multiple seeds are possible.
String[] raw;
String[][] m; //Matches array
StringList done = new StringList(); //Already crawled URLs
int size; 
int max; //Maximum amount of runs
int safe = 1; //Max amount of pages to crawl a frame, save once per frame
Boolean pagerank = false; //Add URLs to file multiple time to indicate page ranking, you could then parse the crawl.txt and assign page rankings
void setup(){
  size(550,325);
  background(180);
  fill(0);
  textSize(35);
  textAlign(CENTER);
  text("Web Spider",width/2,height/2);
  fill(85);
  textSize(30);
  text("Crawling...",width/2,height/2+30);
  pool.append(seed); //Add the magic seed
  output = createWriter("crawl.txt"); 
}
void draw(){
  if(frameCount == max){ //If we have hit max then exit
   done();
  }
  size = pool.size();
  if(size >= safe){ //If pool size execeeds safety then allow some to carry over to next frame
    size = safe;
  }

 for(int c = 0; c < size;c++){
   if(done.hasValue(pool.get(0))){ //If URL has already been crawled then we should just up Page ranking
     pool.remove(0);
     if(pagerank){
     output.println(pool.get(0));
     }
     continue;
   }
      raw = loadStrings(pool.get(0));
      if(raw == null){
        pool.remove(0);
        println("Skipped Crawl: " + pool.get(0));
done.append(pool.get(0));
        continue;
      }
      m = matchAll(join(raw, " "), "href=\"(http://|//)(.*?)\"");
      if(m != null){
        
      for (String[] l : m) { //Loop over all links found
        if(!seed.equals("http://" + l[2])){ //Do not allow to loop back over seed
  pool.append("http://" + l[2]);
        }
      }
      }
println("Crawled: " + pool.get(0));
output.println(pool.get(0));
done.append(pool.get(0));
pool.remove(0);

  }
  output.flush(); 
}
void done(){
  output.close(); 
  exit();
}


