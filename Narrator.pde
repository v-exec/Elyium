class Narrator {
  //list of all entities
  Entity[] entities = new Entity[2];

  //value used to determine which entities in entities[] have been encountered. starts at entities.length and -= 1 every time a new entity is encountered
  int entityTick;

  //variables used for JSON navigation and info retrieval
  JSONObject directory;
  String text;

  //all entities
  Entity monument;

  //on Narrator initialization, all entities are created and filled with their respective data (except for location)
  Narrator() {
    //monument
    directory = data.getJSONObject("monument");
    monument = new Entity(directory);
    entities[0] = monument;

    //other
  }

  public String constructNarrative(Entity object) {
    directory = data.getJSONObject(object.name);
    text = directory.getString("context");
    directory = directory.getJSONObject("conflicts");
    directory = directory.getJSONObject("K1");
    return text + "\n" + "\n" + directory.getString("def");
  }
}