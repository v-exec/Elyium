/*
INTERFACE
 
 This section handles all interfacing, user input management, and user interface status.
 It acts as the primary management unit of all other systems, its hub-like status making it the main communication channel among the different units.
 
 The inteface contains 3 distinc 'modes' or 'states'.
 These 3 states act as management tools / triggers for particular data flow. In other words, many actions related to narrative and location functionalities are dependant on the UI state.
 
 Idle: The state in which the player is not in a narrative sequence, and is simply walking around.
 In this state, the location (see Location.pde) is taking care of getting the player's position relative to other entities, and deciding when to spawn a new entity at the player's current location.
 
 Narrative: The state in which the player has encountered an entity, and is engaged in a narrative sequence.
 In this state, the UI asks for certain bits of narrative information fron the narrator (see Narrator.pde) and puts them together to construct the interface.
 Through the narrator, the interface asks for an image contained within the entity in question, the entity's "context" (piece of introductory narrative), and the conflicts and their respective choices.
 Then, the image, as well as other UI elements, are translated into ASCII using an interface method and displayed accordingly.
 Which conflict is presented is dependant on the narrator. The narrator handles the navigation through the entitiy's branching narrative. The interface only asks for information and visualizes it.
 Depending on the entity's image and an 'animate' boolean contained in the entity, the image is sometimes animated, sometimes not (to avoid lag, and for aesthetic purposes).
 If it is being animated, the entire frame is refreshed. Otherwise, all space under the image (where text, UI, and choices are displayed) is refreshed.
 
 Menu: The state in which the player can enter at any time (regardless of whether they're in the idle state or the narrative state).
 The menu acts as a map tool that shows the player their current real-world coordinates, and the real-world coordinates of all entities they've encountered.
 On the first encounter with an entity, the player is forced into a narrative sequence. In subsequent encounters, however, the player must choose to interact with the entity through the menu.
 The idea is to avoid undesireable engagement in narrative sequences.
 /TODO/
 Once the player is close enough to an entity, it is highlighted to show that it can now be interacted with.
 /TODO/
 
 At all times, the menu button at the bottom right corner is displayed, and the interface is waiting for potential input.
 */

class Interface {
  //images for cover ASCII art
  PImage source;
  int brightnessThresh = 50;
  int imageDensity = 10;

  //characters for ASCII art
  String[] chars = {".", "'", "-", "+", ";", "=", "x", "*", "#"};
  int ASCIIsize = 12;

  //boolean to stop cover image from being re-rendered (to avoid lag for certain images)
  boolean rendered = false;

  //UI elements
  PImage menuIcon;
  PImage choiceIcon = loadImage("choice.png");
  PImage entityIcon = loadImage("entity.png");

  //text elements and formatting
  String text;
  String[] choices = new String[4];
  int choiceSpacing = 120;
  int textSize = 26;

  //state of UI (1 = idle 2 = narrative 3 = menu)
  int state;

  //current entity
  Entity entity;

  //toggles for menu and data loading
  boolean menuToggle = false;
  boolean refresh = true;
  boolean startNarrative = false;
  boolean inNarrative = false;
  boolean inIdle = false;

  //timing parameters
  int minSpawnTime = 5;
  int maxSpawnTime = 5;

  Interface() {
    fill(255);
    noStroke();
  }

  //displays respective UI mode
  public void display() {

    //get input and determine UI state
    control();

    switch (state) {
    case 1:
      idle();
      break;

    case 2:
      narrative(entity);
      break;

    case 3:
      menu();
      break;

    default:
      idle();
      break;
    }

    //display menu icon at all times
    if (menuToggle) menuIcon = loadImage("menuOn.png");
    else menuIcon = loadImage("menuOff.png");
    ASCII(width - 100, height - 100, menuIcon, true);
  }

  ////////////////////////////////////////////////////MODES

  //idle mode
  private void idle() {
    rendered = false;
    inIdle = true;
    background(0);
    source = loadImage("idle.png");

    //set wait timer for entity spawn
    spawn.wait(round(random(minSpawnTime, maxSpawnTime)));

    //if/when narrator spawns entity, start a new narrative
    if (narrator.search()) startNarrative = true;

    //display idle image
    ASCII(width/2 - 250, height/2 - 250, source, true);
  }

  //narrative mode
  private void narrative(Entity object) {
    inIdle = false;

    //get ascii image
    source = object.cover;

    //render once
    if (!rendered) {
      background(0);
      ASCII(width/2 - 250, height/20, source, object.animate);
    }

    //if image is not to be animated, refresh the rest of the screen
    if (!object.animate) {
      fill(0);
      rect(0, height/3, width, (height - height/3));
      rendered = true;
      fill(255);
    }

    //begin narrative (update text and choices list)
    if (!inNarrative) {
      text = narrator.getNarrative(object);
      for (int i = 0; i < choices.length; i++) choices[i] = narrator.getChoice(i);

      refresh = false;
      inNarrative = true;
    }

    //continue narrative after player has provided choice (input) (update text and choices list)
    if (refresh) {
      text = narrator.continueNarrative();
      for (int i = 0; i < choices.length; i++) choices[i] = narrator.getChoice(i);

      refresh = false;
    }

    //display narrative
    rectMode(CORNER);
    textAlign(LEFT);
    textSize(textSize);
    text(text, width/10, height/3, width - (width/10 * 2), height - height/4);

    //display choices
    for (int i = 0; i < choices.length; i++) {
      if (choices[i] != "null") {
        ASCII(width/10, (height/3 * 2) + (i * choiceSpacing), choiceIcon, true);

        rectMode(CORNER);
        textAlign(LEFT);
        textSize(textSize);

        text(choices[i], width/8, (height/3 * 2) + (i * choiceSpacing), width - (width/10 * 2), 50);
      }
    }
  }

  //menu mode
  private void menu() {
    //display coordinates
    background(0);
    textAlign(CENTER);
    textSize(textSize);

    if (mapper.hasLocation) {
      text(mapper.latitude, 100, 100);
      text(mapper.longitude, 100, 100 + 40);
    } else text("No permissions to access location", width/2, height/10);

    //display encountered entities list
    int oi = narrator.entityTick + 1;
    int row = 0;
    int col = 0;
    for (int i = narrator.entityTick + 1; i < narrator.entities.length; i++) {
      if ((i - oi) % 3 == 0) {
        row++;
        col = 0;
      }
      ASCII(width/10 + ((width - width/5)/3 * col), 100 + height/10 * row, entityIcon, true);

      rectMode(CORNER);
      textAlign(LEFT);
      textSize(textSize);

      text(narrator.entities[i].name, width/10 + ((width - width/5)/3 * col), 100 + height/10 * row + 40);
      text(trim(str(narrator.entities[i].latitude)), width/10 + ((width - width/5)/3 * col), 100 + height/10 * row + 80);
      text(trim(str(narrator.entities[i].longitude)), width/10 + ((width - width/5)/3 * col), 100 + height/10 * row + 120);
      col++;
    }
    rendered = false;
  }

  ////////////////////////////////////////////////////CONTROLS & RENDERING

  //handles all user input and controls current state
  private void control() {
    if (input) {
      //menu toggle
      if (mouseX >= width-150 && mouseX <= width && mouseY >= height-150 && mouseY <= height) menuToggle = !menuToggle;

      //choice selection
      if (choices[0] != "null" && choices[0] != null) {
        for (int i = 0; i < choices.length; i++) {
          if (choices[i] != "null") {
            if (mouseX >= width/10 && mouseX <= width - width/10 && mouseY >= (height/3 * 2) + (i * choiceSpacing) && mouseY <= (height/3 * 2) + choiceSpacing + (i * choiceSpacing)) {
              narrator.choose(i);
              refresh = true;
            }
          }
        }
      }

      //entity selection in menu screen
      if (inIdle && menuToggle) {
        int oi = narrator.entityTick + 1;
        int row = 0;
        int col = 0;
        for (int i = narrator.entityTick + 1; i < narrator.entities.length; i++) {
          if ((i - oi) % 3 == 0) {
            row++;
            col = 0;
          }
          if (mouseX >= width/10 + ((width - width/5)/3 * col) && mouseX <= width/10 + ((width - width/5)/3 * col) + 200 && mouseY >= 100 + height/10 * row && mouseY <= 100 + height/10 * row + 100) {
            //on entity click, check if player is close, if entity has any unresolved master conflicts, and if at least one conflict has met all of its conditions
            if (dist(mapper.latitude, mapper.longitude, narrator.entities[i].latitude, narrator.entities[i].longitude) < 0.005) {
              int count = 0;
              for (int j = 0; j < narrator.entities[i].conflicts.length; j++) {
                if (narrator.entities[i].conflicts[j].res == null && narrator.checkConditions(narrator.entities[i].conflicts[j])) count++;
              }
              if (count > 0) {
                entity = narrator.entities[i];
                menuToggle = !menuToggle;
                startNarrative = true;
              }
            }
          }
          col++;
        }
      }

      //LOCATION DEBUGGING
      //if (menuToggle && !mapper.isTracking) {
      //  if (mouseX <= 150 && mouseX >= 0 && mouseY <= height && mouseY >= height-150) {
      //    mapper.latitude = random(-360, 360);
      //    mapper.longitude = random (-360, 360);
      //  }
      //}
    }

    //turn off narrative mode after set amount of time, if resolved
    if (choices[0] == "null" && inNarrative && timer.timed()) inNarrative = false;

    //set state
    if (menuToggle) state = 3;
    else if (startNarrative || inNarrative) {
      state = 2;
      startNarrative = false;
    } else state = 1;
  }

  //draws ASCII-fied version of images. used for menu icon, choice icons, idle image, and entity images
  private void ASCII(int xStart, int yStart, PImage image, boolean animate) {
    textAlign(CENTER);
    textSize(ASCIIsize);
    image.loadPixels();

    for (int x = 0; x < image.width; x += imageDensity) {
      for (int y = 0; y < image.height; y += imageDensity) {
        int loc = x + (y * image.width);
        int brightness = int(brightness(image.pixels[loc]));
        if (animate) {
          if (int(random(0, 1000)) > 1) {
            if (brightness > brightnessThresh) text(chars[int(map(brightness, brightnessThresh, 255, 0, chars.length - 1))], x + xStart, y + yStart);
          }
        } else if (brightness > brightnessThresh) text(chars[int(map(brightness, brightnessThresh, 255, 0, chars.length - 1))], x + xStart, y + yStart);
      }
    }
  }
}