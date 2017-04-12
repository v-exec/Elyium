/*
ELYIUM
 
 This section acts as the primary setup and loop.
 It inializes the unique actors (objects) like the location tracking, narration system, user interfacing, and timekeeping system.
 It also keeps track of input, and dispalys the UI in whatever state it currently is in.
 That is all. This section is meant to stay as minimal as possible. All functinality is to be encapsulated within objects.
 */

//location
Mapper mapper;

//narrative database
JSONArray data;

//save/load file
JSONArray save;
File f;

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

//entity spawn timer
Timer spawn = new Timer();

void setup() {
  size(1200, 600);
  surface.setTitle("Elyium");
  background(0);

  data = loadJSONArray("narrative.json");
  f = new File(dataPath("load.json"));
  if (f.exists()) save = loadJSONArray("load.json");
  else save = loadJSONArray("save.json");

  mapper = new Mapper();
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
  if (!mousePressed) {
    input = false;
    ready = true;
  }

  //display
  UI.display();

  //movement
  mapper.move();

  //reset input to avoid unwanted double-clicks
  input = false;
}