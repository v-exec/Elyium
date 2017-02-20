class Narrator {
  //list of all entities
  Entity[] entities = new Entity[2];

  //value used to determine which entities in entities[] have been encountered. starts at entities.length and -= 1 every time a new entity is encountered
  int entityTick;

  //variables used for JSON navigation, used to populate entities
  JSONObject directory;

  //narrative location tracker and info retrieval (current = current master conflict. sub = subconflict within master)
  String text;
  Conflict current;
  Conflict sub;

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

  //gets a master conflict, and begins a narrative chain
  public String getNarrative(Entity object) {
    text = object.context;
    current = object.conflicts[int(random(0, object.conflicts.length))];
    sub = current;
    text = text + "\n" + "\n" + sub.def;
    return text;
  }

  //continues narrative by going down one branch of the narrative tree
  // public String continueNarrative() {
  // }

  //gets the choices for the currently inhabited conflict
  public String getChoice(int choice) {
    if (sub.choices.length > choice) {
      text = sub.choices[choice].def;
      return text;
    } else return "null";
  }

  //alerts Narrator of choice taken by player
  public void choose(int choice) {
  }
}