class Interface {
  //images for cover ASCII art
  PImage source;
  int brightnessThresh = 50;

  //characters for ASCII art
  String[] chars = {".", "'", "-", "+", ";", "=", "x", "*", "#"};

  //boolean to stop cover image from being re-rendered
  boolean rendered = false;

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
  }

  public void setRendered(boolean bool) {
    rendered = bool;
  }

  private void inter() {
  }

  private void narrative(Entity object) {
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
    data();
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

  private void data() {
    fill(0);
    rectMode(CORNER);
    rect(width - 200, height - 200, 200, 200);

    fill(255);
    textAlign(RIGHT);
    textSize(24);
    //coordinates
    if (mapper.getHasLocation()) {
      text("Lat: " + mapper.getLatitude(), width, height);
      text("Lon: " + mapper.getLongitude(), width, height - 20);
    } else {
      text("No permissions to access location", width, height - 20);
    }
  }
}