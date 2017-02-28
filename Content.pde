/*
CONTENT
 
 This section deals with taking the database and translating it into objects.
 Each entity contains conflicts. Each conflict contains choices.
 Each choice contains either another conflict (continuing the chain), or a resolution (ending the chain).
 The conflict and choice objects act as containers for the narrative data that is fetched from the JSON database.
 
 The purpose is to avoid constantly referring to the JSON file, but instead create a data structure that represents the JSON data in memory.
 This way, all the data is loaded on start, including any player progress saved within the database.
 */

//conflict class, holds conflict data and set of choices
class Conflict {
  String name;
  String def;
  String res ="null";

  Choice[] choices;

  Conflict(JSONObject dir) {
    this.name = dir.getString("name");
    this.def = dir.getString("def");

    //if conflict has 'res' key, add it. only master conflicts have a 'res' key
    if (dir.hasKey("res")) this.res = dir.getString("res");

    //get choices
    choices = new Choice[dir.getJSONArray("choices").size()];

    for (int i = 0; i < choices.length; i++) {
      JSONArray cho = dir.getJSONArray("choices");
      choices[i] = new Choice(cho.getJSONObject(i));
    }
  }
}

//choices class, holds either a 'res' (resolution) key or a 'con' (conflict) key
class Choice {
  String name;
  String def;
  String res = "null";
  Conflict conflict;

  Choice(JSONObject dir) {
    this.name = dir.getString("name");
    this.def = dir.getString("def");

    //only final choices have a 'res' key, and only non-final choices have a 'con' key
    if (dir.hasKey("res")) this.res = dir.getString("res");
    if (dir.hasKey("con")) this.conflict = new Conflict(dir.getJSONObject("con"));
  }
}