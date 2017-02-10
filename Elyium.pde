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
  UI.display(2);

  //if (mousePressed) {
  //  if (ready) {
  //    UI.setRendered(false);
  //  } else {
  //    UI.setRendered(false);
  //  }
  //  ready = false;
  //}
  //if (mousePressed == false) ready = true;
}