class Narrator {
  //list of all entities
  Entity[] entities = new Entity[2];

  //value used to determine which entities in entities[] have been encountered. starts at entities.length and -= 1 every time a new entity is encountered
  int entityTick;

  //variables used for JSON navigation and info retrieval
  JSONObject directory;
  String conflict;
  String[] choices;

  //all entities
  Entity monument;

  Narrator() {
    //monument
    directory = data.getJSONObject("monument");
    monument = new Entity(directory.getString("name"), directory.getString("cover"), directory.getBoolean("animate"), directory.getInt("keys"));
    entities[0] = monument;
    
    //other
  }

  public String constructNarrative(Entity object) {
    directory = data.getJSONObject(object.name);
    directory = directory.getJSONObject("conflicts");
    return directory.getString("C1");
  }
}