import processing.video.*;
import oscP5.*;
import netP5.*;

Capture cam;
OscP5 OSC;
NetAddress myRemoteLocation;

float r,g,b;
boolean isLoading = true;
boolean sendOSC = false;

int OSC_PORT = 6448;
String OSC_IP = "127.0.0.1";
String INPUT_MSG = "/wek/inputs";

void setup() {
  size(700, 760);
  background(#15394c);
  
  String[] cameras = Capture.list();
  
  if (cameras.length == 0) {
    println("There are no cameras available for capture.");
    exit();
  } else {
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }
    
    // The camera can be initialized directly using an 
    // element from the array returned by list():
    cam = new Capture(this, cameras[0]);
    cam.start();     
  }
  
  OSC = new OscP5(this, 12000);
  myRemoteLocation = new NetAddress(OSC_IP, OSC_PORT);
}      

void draw() {
  
  stroke(#BEA55F);
  noFill();
  
  // BUTTONS
  rect(30, 660, 305, 70);
  rect(365, 660, 305, 70);
  
  if(mouseX >= 30 && mouseX <= 335 && mouseY >= 660 && mouseY <= 730) {
    cursor(HAND);
  } else if (mouseX >= 365 && mouseX <= 670 && mouseY >= 660 && mouseY <= 730) {
    cursor(HAND);
  } else {
    cursor(ARROW);
  }
  
  // TEXT
  textSize(32);
  fill(#BEA55F);
  text("START OSC", 30 + 32, 660 + 48);
  text("STOP OSC", 365 + 32, 660 + 48);
  
  if (cam.available() == true) {
    cam.read();
    cam.loadPixels();
    
    r = 0;
    g = 0; 
    b = 0;
    float l = cam.pixels.length;
    for(int i = 0; i <= cam.pixels.length-1; i++) {
      r += red(cam.pixels[i]);
      g += green(cam.pixels[i]);
      b += blue(cam.pixels[i]);
    }
    r = round(r / l);
    g = round(g / l);
    b = round(b / l);
    int c = color(r, g, b);
   
    if(sendOSC) {
      OscMessage wekInput = new OscMessage(INPUT_MSG);
      wekInput.add(map(r, 0, 255, 0, 1));
      wekInput.add(map(g, 0, 255, 0, 1));
      wekInput.add(map(b, 0, 255, 0, 1));
      OSC.send(wekInput, myRemoteLocation);
    }
    
    fill(c);
    stroke(#BEA55F);
    rect(30, 510, 640, 120);
    
    image(cam, 30, 30, 640, 480);
    stroke(#BEA55F);
    noFill();
    rect(30, 30, 640, 480);
  }
}

void mouseClicked() {
  if(mouseX >= 30 && mouseX <= 335 && mouseY >= 660 && mouseY <= 730) {
    startOsc();
  } else if (mouseX >= 365 && mouseX <= 670 && mouseY >= 660 && mouseY <= 730) {
     stopOsc();
  }

}

void startOsc() {
  sendOSC = true;
  println("Start Osc");
}

void stopOsc() {
  sendOSC = false;
  println("Stop Osc");
}
