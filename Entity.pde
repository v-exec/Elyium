class Entity {
  //entity name
  String name;

  //location in real-world coordinates
  float latitude;
  float longitude;

  //cover image for entity
  PImage cover;
  boolean animate;

  //list of key decisions taken with this entity, used in narration construction to omit or allow certain choices
  boolean[] decisions;

  //initializes entity, and assigns it a number of key decisions to keep track of
  Entity(String name, String img, boolean animate, int decisionNum) {
    this.name = name;
    this.cover = loadImage(img);
    this.animate = animate;
    decisions = new boolean[decisionNum];
  }

  //assigns location to entity once it's been encountered
  public void assignLocation(float latitude, float longitude) {
    this.latitude = latitude;
    this.longitude = longitude;
  }
}