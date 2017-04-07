/*
NARRATOR
 
 This section takes care of initializing all entities, and beginning the data population process (see Entity.pde for the other parts of the process) through the JSON database.
 The narrator also handles the providing of narrative data to the interface (see Interface.pde) by navigating the narrative data structures (entities).
 It also makes sure that conflicts with conditions have met those conditions (see Content.pde) before being presented in a narrative sequence.
 
 Additionally, this section handles determining whether an entity spawn is appropriate, and providing entities with location data once they've been encountered.
 The narrator keeps track of all encountered entities.
 After each narrative sequence is resolved, the unique resolution reached by the player is saved to the conflict, which is then written onto the JSON database.
 This acts as the saving system. It is also used for conditional conflicts, when a conflict must see if another conflict has been resolved in a specific way.
 */

class Narrator {
  //array of all entities
  Entity[] entities = new Entity[data.size()];

  //value used to determine which entities in entities[] have been encountered. starts at entities.length and -= 1 every time a new entity is encountered
  int entityTick = entities.length - 1;

  //narrative data location tracker and info retrieval (current = current master conflict. sub = subconflict within master. cho = final choice taken for master conflict / resolution choice)
  Conflict current;
  Conflict sub;
  Choice cho;
  String text;

  //conflict resolution flag
  boolean resolved = false;

  //on Narrator initialization, all entities are created and filled with their respective data (except for location)
  //then, all entities in array are rearranged so that entities that have been encountered in previous runtime (seen through existence of resolution in save.json) are considered as encountered
  Narrator() {
    for (int i = 0; i < entities.length; i++) {
      entities[i] = new Entity(data.getJSONObject(i));
    }

    for (int i = entityTick; i > -1; i--) {
      for (int j = 0; j < entities[i].conflicts.length; j++) {
        if (entities[i].conflicts[j].res != null) {
          Entity temp = entities[i];
          entities[i] = entities[entityTick];
          entities[entityTick] = temp;
          entityTick--;
          break;
        }
      }
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

  //continues narrative, or displays the conflict resolution and notes it in the master conflict and saves if resolved, or resets conflict if resolution string starts with 'RESET-'
  public String continueNarrative() {
    if (resolved) {
      if (cho.res.substring(0, 6).equals("RESET-")) {
        resolved = false;
        text = cho.res.substring(6);
        sub = current;
      } else {
        text = cho.res;
        current.res = cho.name;
        saveGame();
        timer.wait(10);
      }
    } else text = sub.def;
    return text;
  }

  //gets the choices for the currently inhabited conflict
  public String getChoice(int choice) {
    if (!resolved && sub.choices.length > choice) {
      text = sub.choices[choice].def;
      return text;
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

  //'searches' for entities to spawn
  public boolean search() {
    if (entityTick <= -1) return false;

    //check if player is sufficiently far from encountered entities to spawn new entity
    for (int i = entityTick + 1; i < entities.length; i++) {
      if (dist(mapper.latitude, mapper.longitude, entities[i].latitude, entities[i].longitude) < 0.005) return false;
    }

    //check if player has waited long enough to spawn new entity
    if (spawn.timed()) {

      //check if there are custom entities near player to encounter before fetching a random one
      for (int i = 0; i <= entityTick; i++) {
        if (entities[i].latitude != 444.001) {
          if (dist(mapper.latitude, mapper.longitude, entities[i].latitude, entities[i].longitude) < 0.006) {
            UI.entity = entities[i];
            Entity temp = entities[i];
            entities[i] = entities[entityTick];
            entities[entityTick] = temp;
            entityTick--;

            return true;
          }
        }
      }

      //picks a random unencountered entity and 'encounters' them, putting them beyond entityTick in entites[]
      int entityIndex = round(random(0, entityTick));
      UI.entity = entities[entityIndex];
      entities[entityIndex].latitude = mapper.latitude;
      entities[entityIndex].longitude = mapper.longitude;

      Entity temp = entities[entityIndex];
      entities[entityIndex] = entities[entityTick];
      entities[entityTick] = temp;
      entityTick--;

      return true;
    }
    return false;
  }

  //checks whether or not the conditions for a conflict have been met
  private boolean checkConditions(Conflict con) {
    if (con.conditions == null)
      return true;

    int countVerified = con.conditions.length;

    for (int i = 0; i < con.conditions.length; i++) {
      for (int j = 0; j < entities.length; j++) {
        if (entities[j].name.equals(con.conditions[i].entity)) {
          for (int k = 0; k < entities[j].conflicts.length; k++) {
            if (entities[j].conflicts[k].name.equals(con.conditions[i].con)) {
              if (entities[j].conflicts[k].res != null) {
                if (entities[j].conflicts[k].res.equals(con.conditions[i].res)) {
                  countVerified--;
                  if (countVerified == 0) return true;
                }
              }
            }
          }
        }
      }
    }
    return false;
  }

  //saves encountered entities, their coordinates, and their conflict resolutions (saves to android /data folder, not typical processing sketch data folder)
  private void saveGame() {
    //clear entities before saving
    save = new JSONArray();

    for (int i = entityTick + 1; i < entities.length; i++) {
      JSONObject se = new JSONObject();
      se.setString("name", entities[i].name);
      se.setFloat("latitude", entities[i].latitude);
      se.setFloat("longitude", entities[i].longitude);

      for (int j = 0; j < entities[i].conflicts.length; j++) {
        if (entities[i].conflicts[j].res != null) {
          se.setString(entities[i].conflicts[j].name, entities[i].conflicts[j].res);
        }
      }
      save.append(se);
    }
    saveJSONArray(save, Environment.getExternalStorageDirectory().getAbsolutePath() + "/data/save.json");
  }
}