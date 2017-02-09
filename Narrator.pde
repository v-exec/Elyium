class Narrator {
  //list of all entities
  Entity[] entities;

  //list of all encountered entities (moved to here when first encountered)
  Entity[] encountered;

  //value used to determine which entities in entities[] have been encountered. starts at entities.length and -= 1 every time a new entity is encountered
  int entityTick;

  Narrator() {
  }

  //public Entity constructEntity() {

  //}

  //public String constructNarrative(Entity object) {
  //object.conflicts[
  //}
}