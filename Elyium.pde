//android API context
import android.content.Context;

//location sensor
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Bundle;
import android.Manifest;

//location
Mapper mapper;

//narrative database
JSONObject data;

//narrative generator and manager
Narrator narrator;

//interface
Interface UI;
PFont console;

//checker to avoid unwanted double-clicking
boolean ready = true;

//UI state / toggles
boolean menuToggle = false;

//general use timer (mostly for animations)
Timer timer = new Timer();

void setup() {
  fullScreen();
  background(0);

  data = loadJSONObject("narrative.json");
  narrator = new Narrator();

  UI = new Interface();
  console = createFont("Menlo-Regular.ttf", 24, false);
  textFont(console);
}

void draw() {
  if (menuToggle) {
    UI.display(3);
  } else {
    UI.display(2);
  }

  //controls
  if (mousePressed) {
    if (ready) {

      //menu toggle
      if (mouseX <= width && mouseX > width-150 && mouseY <= height && mouseY > height-150) menuToggle = !menuToggle;
     





      ready = false;
    }
  }
  //reset mouse press to avoid unwanted double-clicks
  if (mousePressed == false) ready = true;
}