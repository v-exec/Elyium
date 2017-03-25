/*
CONTENT
 
 This section deals with taking the database and translating it into objects.
 Each entity contains conflicts. Each conflict contains choices (and each master conflict can contain a condition).
 Each choice contains either another conflict (continuing the chain), or a resolution (ending the chain).
 The conflict and choice objects act as containers for the narrative data that is fetched from the JSON database.
 
 Conflicts with condition(s) can only be presented once the condition(s) have been met, if any.
 Conditions are data structures that contain a 'map' (entity.conflict.resolution) pointing to the conflict whose acquired resolution must be checked.
 
 Despite master conflicts being different from subconflicts, and final choices being different from other choices, all conflicts and all choices are the same class.
 This causes a bit of unnecessary bloat in terms of the database, however it makes managing the data much easier, as it is all quite uniform and standardized.
 Also, the JSON file and the data structures in Elyium are *not* identical. The JSON file acts only as a static source for narrative content, all additional dynamics are handled at runtime in this alternate data system. 
 
 The purpose is to avoid constantly referring to the JSON file, but instead create a data structure that represents the JSON data in memory.
 This way, all the content is loaded from the database on start and never referred to again.
 */

//conflict class, holds conflict data and set of choices
class Conflict {
  String name;
  String def;
  String res;

  Condition[] conditions;
  Choice[] choices;

  Conflict(JSONObject dir) {
    if (dir.hasKey("name")) this.name = dir.getString("name");
    this.def = dir.getString("def");

    //get conditions
    if (dir.hasKey("conditions")) {
      conditions = new Condition[dir.getJSONArray("conditions").size()];

      for (int i = 0; i < conditions.length; i++) {
        JSONArray cond = dir.getJSONArray("conditions");
        conditions[i] = new Condition(cond.getJSONObject(i));
      }
    }

    //get choices
    choices = new Choice[dir.getJSONArray("choices").size()];

    for (int i = 0; i < choices.length; i++) {
      JSONArray cho = dir.getJSONArray("choices");
      choices[i] = new Choice(cho.getJSONObject(i));
    }
  }
}

//choices class, choice definition, as well as a sub-conflict or a resolution to the master conflict
class Choice {
  String name;
  String def;
  String res;
  Conflict conflict;

  Choice(JSONObject dir) {
    if (dir.hasKey("name")) this.name = dir.getString("name");
    this.def = dir.getString("def");

    //only final choices have a 'res' key, and only non-final choices have a 'con' key
    if (dir.hasKey("res")) this.res = dir.getString("res");
    if (dir.hasKey("con")) this.conflict = new Conflict(dir.getJSONObject("con"));
  }
}

//condition class, holds three pieces of data (entity, conflict, resolution) that act as map/guide to condition to be verified
class Condition {
  String entity;
  String con;
  String res;

  Condition(JSONObject dir) {
    this.entity = dir.getString("entity");
    this.con = dir.getString("con");
    this.res = dir.getString("res");
  }
}