class Narrator {
  //list of all entities
  Entity[] entities = new Entity[2];

  //value used to determine which entities in entities[] have been encountered. starts at entities.length and -= 1 every time a new entity is encountered
  int entityTick;

  //variables used for JSON navigation and info retrieval
  JSONObject directory;
  String text;
  String[] choices;

  //all entities
  Entity monument;

  Narrator() {
    //monument
    directory = data.getJSONObject("monument");
    monument = new Entity(directory.getString("name"), directory.getString("cover"), directory.getBoolean("animate"));
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