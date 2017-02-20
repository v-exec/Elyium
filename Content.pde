class Conflict {
  String name;
  String def;
  String res;
  
  Choice[] choices;

  Conflict(JSONObject dir) {
    this.name = dir.getString("name");
    this.def = dir.getString("def");
    
    if (dir.hasKey("res")) this.res = dir.getString("res");
    
    //get choices
    choices = new Choice[dir.getJSONArray("choices").size()];
    
    for (int i = 0; i < choices.length; i++) {
      JSONArray cho = dir.getJSONArray("choices");
      choices[i] = new Choice(cho.getJSONObject(i));
    }
  }
}

class Choice {
  String name;
  String def;
  String res;
  Conflict conflict;

  Choice(JSONObject dir) {
    this.name = dir.getString("name");
    this.def = dir.getString("def");
    
    if (dir.hasKey("res")) this.res = dir.getString("res");
    
    if (dir.hasKey("con")) this.conflict = new Conflict(dir.getJSONObject("con"));
  }
}