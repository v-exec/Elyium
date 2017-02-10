class Interface {
  //images for cover ASCII art
  PImage source;
  int brightnessThresh = 50;

  //characters for ASCII art
  String[] chars = {".", "'", "-", "+", ";", "=", "x", "*", "#"};

  //boolean to stop cover image from being re-rendered
  boolean rendered = false;

  //menu button UI
  boolean inMenu = false;
  PImage menuIcon;

  Interface() {
  }

  //displays UI, animates UI depending on entity cover (if cover is too bright and renders too much text, animation is set to off to avoid lag)
  public void display(int state) {
    switch (state) {
    case 1:
      inter();
      break;

    case 2:
      narrative(narrator.monument);
      break;

    case 3:
      menu();
      break;

    default:
      inter();
      break;
    }

    displayMenu();
  }

  public void setRendered(boolean bool) {
    rendered = bool;
  }

  private void inter() {
    inMenu = false;
    rendered = false;
  }

  private void narrative(Entity object) {
    inMenu = false;

    //get narrative


    //display narrative


    //display ascii image
    source = object.cover;

    if (rendered == false) {
      background(0);
      ASCII(object.animate);
      if (object.animate == false) rendered = true;
    }
  }

  private void menu() {
    inMenu = true;
    coords();
    rendered = false;
  }

  private void ASCII(boolean animate) {
    source.loadPixels();

    textAlign(CENTER);
    fill(255);
    noStroke();
    textSize(12);

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

  private void displayMenu() {
    textAlign(CENTER);
    fill(255);
    noStroke();
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

  private void coords() {
    background(0);
    fill(255);
    textAlign(CENTER);
    textSize(35);

    //coordinates
    if (mapper.getHasLocation()) {
      text("Lat: " + mapper.getLatitude(), width/2, height/10);
      text("Lon: " + mapper.getLongitude(), width/2, height/10 + 40);
    } else text("No permissions to access location", width/2, height/10);
  }
}