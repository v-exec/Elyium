/*
NARRATOR
 
 This section takes care of initializing all entities, and beginning the data population process (see Entity.pde and Content.pde for the two other parts of the process) through the JSON database.
 The narrator also handles the providing of narrative data to the interface (see Interface.pde) by navigating the narrative data structures (entities).
 It also makes sure that conflicts with conditions have met those conditions (see Content.pde) before being presented in a narrative sequence.
 
 /TODO/
 The narrator keeps track of all encountered entities.
 After each narrative sequence is resolved, the unique resolution reached by the player is saved to the conflict, which is then written onto the JSON database.
 This acts as the saving system. It is also used for conditional conflicts, when a conflict must see if another conflict has been resolved in a specific way.
 /TODO/
 */

class Narrator {
  //array of all entities
  Entity[] entities = new Entity[data.size()];

  //value used to determine which entities in entities[] have been encountered. starts at entities.length and -= 1 every time a new entity is encountered
  int entityTick = entities.length;

  //narrative data location tracker and info retrieval (current = current master conflict. sub = subconflict within master. cho = final choice taken for master conflict / resolution choice)
  Conflict current;
  Conflict sub;
  Choice cho;
  String text;

  //conflict resolution flag
  boolean resolved = false;

  //on Narrator initialization, all entities are created and filled with their respective data (except for location)
  Narrator() {
    for (int i = 0; i < entities.length; i++) {
      entities[i] = new Entity(data.getJSONObject(i));
    }
  }

  //gets a master conflict (checks for conflict's condition(s)), and begins narrative chain
  public String getNarrative(Entity object) {
    resolved = false;
    text = object.context;

    //get master conflict and check for conditions
    current = object.conflicts[int(random(0, object.conflicts.length))];
    while (checkConditions(current) == false) {
      current = object.conflicts[int(random(0, object.conflicts.length))];
    }

    sub = current;
    text = text + "\n" + "\n" + sub.def;
    return text;
  }

  //continues narrative, or displays the conflict resolution and notes it in the master conflict
  public String continueNarrative() {
    if (resolved) {
      text = cho.res;
      current.res = cho.name;
      timer.wait(10000);
    } else text = sub.def;
    return text;
  }

  //gets the choices for the currently inhabited conflict
  public String getChoice(int choice) {
    if (!resolved) {
      if (sub.choices.length > choice) {
        text = sub.choices[choice].def;
        return text;
      } else return "null";
    } else return "null";
  }

  //alerts Narrator of choice taken by player, and goes down one branch of narrative tree if there is one, otherwise alerts Narrator of conflict resolution
  public void choose(int choice) {
    if (sub.choices[choice].res == null) {
      sub = sub.choices[choice].conflict;
    } else {
      cho = sub.choices[choice];
      resolved = true;
    }
  }

  //checks whether or not the conditions for a conflict have been met
  private boolean checkConditions(Conflict con) {
    if (con.conditions == null) return true;
    else {
      boolean[] verified = new boolean[con.conditions.length];

      for (int i = 0; i < con.conditions.length; i++) {
        for (int j = 0; j < entities.length; j++) {
          if (entities[j].name.equals(con.conditions[i].entity)) {
            for (int k = 0; k < entities[j].conflicts.length; k++) {
              if (entities[j].conflicts[k].name.equals(con.conditions[i].con)) {
                if (entities[j].conflicts[k].res != null) {
                  if (entities[j].conflicts[k].res.equals(con.conditions[i].res)) verified[i] = true;
                }
              }
            }
          }
        }
      }
      for (int i = 0; i < verified.length; i++) {
        if (!verified[i]) return false;
      }
      return true;
    }
  }
}