/*
LOCATION
 
 This section takes care of getting the player position, and provides this information to other units when necessary.
 */

//location listener and map provider
class Mapper {
  //location coordinates
  float latitude  = 0.0;
  float longitude = 0.0;

  //control sensitivity
  float sensitivity = 0.001;

  Mapper() {
    //
  }

  //move with WASD keys
  public void move() {
    if (keyPressed) {
      if (key == 'w') {
        latitude += sensitivity;
      } else if (key == 's') {
        latitude -= sensitivity;
      } else if (key == 'd') {
        longitude += sensitivity;
      } else if (key == 'a') {
        longitude -= sensitivity;
      }
    }
  }
}