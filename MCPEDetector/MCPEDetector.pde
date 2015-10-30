import hypermedia.net.*;
import ddf.minim.*;
import java.math.BigInteger;
import java.nio.charset.*;
Minim minim;
UDP udp;  
String ADVERTISE = "1c000000000000af67ffaf4e2c18e2864900ffff00fefefefefdfdfdfd12345678";
int mcpe = 0;
String str = "MCCPP;Demo;Steve";
void setup() {

  size(500, 500);
  minim = new Minim(this);
  background(0);
  udp = new UDP(this, 19132);
  udp.listen(true);
  frameRate(10);
}
void draw() {
  if (mcpe != 0 && mcpe+25 > frameCount) {
    background(255);
    textSize(32);
    fill(0);
    textAlign(CENTER);
    text("Client Online", 250, 250);
  }
  else {
    mcpe = 0;
    background(0);
    textSize(32);
    fill(255);
    textAlign(CENTER);
    text("Client Offline", 250, 250);
  }
}
void receive( byte[] data, String ip, int port ) { 
  if (mcpe == 0) minim.loadFile("beep-02.mp3").play();
  mcpe = frameCount;
  if(data[0] == 1) udp.send(javax.xml.bind.DatatypeConverter.parseHexBinary("1c000000000000af67ffaf4e2c18e2864900ffff00fefefefefdfdfdfd12345678" + Integer.toHexString(str.length()) + toHex(str)),ip,port);
  else if(data[0] == 5)udp.send(javax.xml.bind.DatatypeConverter.parseHexBinary("0600ffff00fefefefefdfdfdfd12345678ffaf4e2c18e286490005b8"),ip,port);
  else if(data[0] == 7) udp.send(javax.xml.bind.DatatypeConverter.parseHexBinary("0800ffff00fefefefefdfdfdfd12345678ffaf4e2c18e28649" + Integer.toHexString(port) + "00"),ip,port);
}
String toHex(String arg) {
    return String.format("%040x", new BigInteger(1, arg.getBytes(StandardCharsets.UTF_8)));
}

