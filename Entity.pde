class Entity {
  //entity name
  String name;

  //location in real-world coordinates
  float latitude;
  float longitude;

  //cover image for entity
  PImage cover;
  boolean animate;

  //conflicts
  Conflict[] conflicts;

  //initializes entity by accessing the database and fetching its main info and starting the conflict fill process
  Entity(JSONObject dir) {
    this.name = dir.getString("name");
    this.cover = loadImage(dir.getString("cover"));
    this.animate = dir.getBoolean("animate");
  }

  //assigns location to entity once it's been encountered
  public void assignLocation(float latitude, float longitude) {
    this.latitude = latitude;
    this.longitude = longitude;
  }
}