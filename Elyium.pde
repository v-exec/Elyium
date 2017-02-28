/*
ELYIUM
 
 This section acts as the primary setup and loop.
 It inializes the unique actors (objects) like the location tracking, narration system, user interfacing, and timekeeping system.
 It also keeps track of input, and dispalys the UI in whatever state it currently is in.
 That is all. This section is meant to stay as minimal as possible. All functinality is to be encapsulated within objects.
 */

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

//UI input flag
boolean input = false;

//general use timer
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
  //on mouse press, alert that there's input
  if (mousePressed) {
    if (ready) {
      input = true;
      ready = false;
    }
  }

  //reset mouse press to avoid unwanted double-clicks
  if (mousePressed == false) {
    input = false;
    ready = true;
  }

  //display
  UI.display();

  //reset input to avoid unwanted double-clicks
  input = false;
}