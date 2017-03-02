/*
LOCATION
 
 This section takes care of getting the player position, as well as assigning entities' locations, and then triggering a narrative sequence when an entity is encountered for the first time.
 /TODO/
 The system for spawning entities is not currently developed. Currently, it is simply keeping track of the player's real-world location.
 /TODO/
 */

//location listener and map provider
class Mapper implements LocationListener {
  //location coordinates
  float latitude  = 0;
  float longitude = 0;

  //internal check variable
  boolean hasLocation = false;

  //on new data reception, update gps data
  public void onLocationChanged(Location location) {
    //super rough estimate: 0.009 degrees = 1 km
    latitude  = (float)location.getLatitude();
    longitude = (float)location.getLongitude();
  }

  //must implement abstract methods from LocationListener
  public void onProviderDisabled (String provider) {
    //clear
  }
  public void onProviderEnabled (String provider) {
    //clear
  }
  public void onStatusChanged (String provider, int status, Bundle extras) {
    //clear
  }
}