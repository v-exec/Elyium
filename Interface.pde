class Interface {
  //images for cover ASCII art
  PImage source;
  int brightnessThresh = 50;

  //characters for ASCII art
  String[] chars = {".", "'", "-", "+", ";", "=", "x", "*", "#"};

  //boolean to stop cover image from being re-rendered
  boolean rendered = false;

  //UI elements
  PImage menuIcon;
  PImage choiceIcon = loadImage("choice.png");

  //text elements
  String text;
  String[] choices = new String[5];

  //state of UI (1 = idle 2 = narrative 3 = menu)
  int state;

  //toggles for menu and data loading
  boolean menuToggle;
  boolean inMenu = false;
  boolean loaded = false;
  boolean refresh = true;

  Interface() {
    fill(255);
    noStroke();
  }

  //displays UI, animates UI depending on entity cover (if cover is too bright and renders too much text, animation is set to off to avoid lag)
  public void display() {
    switch (state) {
    case 1:
      idle();
      break;

    case 2:
      narrative(narrator.monument);
      break;

    case 3:
      menu();
      break;

    default:
      idle();
      break;
    }

    displayMenu();
    control();
  }

  public void setRendered(boolean bool) {
    rendered = bool;
  }

  ////////////////////////////////////////////////////IDLE

  private void idle() {
    inMenu = false;
    rendered = false;
  }

  ////////////////////////////////////////////////////NARRATIVE GEN

  private void narrative(Entity object) {
    inMenu = false;

    //get ascii image
    source = object.cover;

    //refresh frames if ascii image is animated
    if (rendered == false) {
      background(0);
      displayImage(object.animate);
      if (object.animate == false) rendered = true;
    }

    //update narrative information (once)
    if (refresh) {
      updateNarrative(object);
      refresh = false;
    }

    //display narrative
    displayNarrative();

    //get and display choices
    for (int i = 0; i < choices.length; i++) {
      if (choices[i] != "null") displayChoice(i, choices[i]);
    }
  }

  private void updateNarrative(Entity object) {
    text = narrator.getNarrative(object);

    choices[0] = "Push the extruded wall.";
    choices[1] = "Pull the extrusion.";
    choices[2] = "null";
    choices[3] = "null";
    choices[4] = "null";
  }

  ////////////////////////////////////////////////////NARRATIVE DISPLAY

  private void displayNarrative() {
    rectMode(CORNER);
    textAlign(LEFT);
    textSize(24);

    text(text, width/10, height/3, width - (width/10 * 2), height - height/4);
  }

  private void displayImage(boolean animate) {
    textAlign(CENTER);
    textSize(12);

    source.loadPixels();

    for (int x = 0; x < source.width; x += 10) {
      for (int y = 0; y < source.height; y += 10) {
        int loc = x + (y * source.width);

        int brightness = int(brightness(source.pixels[loc]));
        if (animate == false) {
          if (brightness > brightnessThresh) text(chars[int(map(brightness, brightnessThresh, 255, 0, chars.length - 1))], x + width/4 + (width/2 - 500), y + height/20);
        } else {
          if (int(random(0, 1000)) > 1) {
            if (brightness > brightnessThresh) text(chars[int(map(brightness, brightnessThresh, 255, 0, chars.length - 1))], x + width/4 + (width/2 - 500), y + height/20);
          }
        }
      }
    }
  }

  private void displayChoice(int num, String string) {
    textAlign(CENTER);
    textSize(12);

    choiceIcon.loadPixels();

    for (int x = 0; x <= choiceIcon.width; x += 10) {
      for (int y = 0; y <= choiceIcon.height; y += 10) {
        int loc = constrain(x + (y * choiceIcon.width), 0, choiceIcon.pixels.length-1);

        int brightness = int(brightness(choiceIcon.pixels[loc]));
        if (int(random(0, 1000)) > 1) {
          if (brightness > brightnessThresh) text(chars[int(map(brightness, brightnessThresh, 255, 0, chars.length - 1))], x + width/10, y + (height/3 * 2) + (num * 100));
        }
      }
    }
    rectMode(CORNER);
    textAlign(LEFT);
    textSize(24);

    text(string, width/8, (height/3 * 2) + (num * 100), width - (width/10 * 2), 50);
  }

  ////////////////////////////////////////////////////MENU

  private void menu() {
    inMenu = true;
    coords();
    rendered = false;
  }

  private void coords() {
    background(0);
    textAlign(CENTER);
    textSize(24);

    //coordinates
    if (mapper.getHasLocation()) {
      text("Lat: " + mapper.getLatitude(), width/2, height/10);
      text("Lon: " + mapper.getLongitude(), width/2, height/10 + 40);
    } else text("No permissions to access location", width/2, height/10);
  }

  ////////////////////////////////////////////////////ALWAYS DISPLAY

  private void displayMenu() {
    textAlign(CENTER);
    textSize(12);

    if (inMenu) menuIcon = loadImage("menuOn.png");
    else menuIcon = loadImage("menuOff.png");
    menuIcon.loadPixels();

    for (int x = 0; x <= menuIcon.width; x += 10) {
      for (int y = 0; y <= menuIcon.height; y += 10) {
        int loc = constrain(x + (y * menuIcon.width), 0, menuIcon.pixels.length-1);

        int brightness = int(brightness(menuIcon.pixels[loc]));
        if (int(random(0, 1000)) > 1) {
          if (brightness > brightnessThresh) text(chars[int(map(brightness, brightnessThresh, 255, 0, chars.length - 1))], x + width - 100, y + height - 100);
        }
      }
    }
  }

  private void control() {
    if (input) {
      if (mouseX <= width && mouseX > width-150 && mouseY <= height && mouseY > height-150) menuToggle = !menuToggle;
    }

    if (menuToggle) state = 3;
    else state = 2;
  }
}