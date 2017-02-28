/*
ENTITY
 
 This section handles the entities in the system.
 Entities act as the main containers for the narrative data. Within them are conflicts, within which there are choices (see Content.pde for information about this object chain).
 Aside from conflicts and narrative data, an entity also contains a real-world coordinate that is assigned to it when the location system decides it should appear to the player (see Location.pde).
 */

class Entity {
  //entity name
  String name;

  //entity context phrase
  String context;

  //location in real-world coordinates
  float latitude;
  float longitude;

  //cover image for entity
  PImage cover;
  boolean animate;

  //conflict objects
  Conflict[] conflicts;

  //initializes entity by accessing the database and fetching its main info and starting the conflict fill process
  Entity(JSONObject dir) {
    this.name = dir.getString("name");
    this.cover = loadImage(dir.getString("cover"));
    this.animate = dir.getBoolean("animate");
    this.context = dir.getString("context");

    this.latitude = dir.getFloat("latitude");
    this.longitude = dir.getFloat("longitude");

    //get conflicts
    conflicts = new Conflict[dir.getJSONArray("conflicts").size()];

    for (int i = 0; i < conflicts.length; i++) {
      JSONArray con = dir.getJSONArray("conflicts");
      conflicts[i] = new Conflict(con.getJSONObject(i));
    }
  }

  //assigns location to entity once it's been encountered
  public void assignLocation(float latitude, float longitude) {
    this.latitude = latitude;
    this.longitude = longitude;
  }
}