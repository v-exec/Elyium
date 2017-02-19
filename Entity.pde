class Entity {
  //entity name
  String name;

  //location in real-world coordinates
  float latitude;
  float longitude;

  //cover image for entity
  PImage cover;
  boolean animate;

  //initializes entity, and assigns it a number of key decisions to keep track of
  Entity(String name, String img, boolean animate) {
    this.name = name;
    this.cover = loadImage(img);
    this.animate = animate;
  }

  //assigns location to entity once it's been encountered
  public void assignLocation(float latitude, float longitude) {
    this.latitude = latitude;
    this.longitude = longitude;
  }
}