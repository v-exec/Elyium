/*
PARSING
 
 This is a small script for putting together all entities into a single file, named "narrative.json".
 Entities are initially created in separate .json files so as to allow modularity and fully independant development of different entities.
 */

File f = new File(dataPath(""));
String[] listPath = f.list();

JSONObject[] entities = new JSONObject[listPath.length];
JSONArray narrative = new JSONArray();

for (int i = 0; i < listPath.length; i++) {
  entities[i] = loadJSONObject(listPath[i]);
  narrative.append(entities[i]);
}

saveJSONArray(narrative, "narrative.json");
exit();