/*
LOCATION
 
 This section takes care of getting the player position, and provides this information to other units when necessary.
 */

//location listener and map provider
class Mapper implements LocationListener {
  //location coordinates
  float latitude  = 0;
  float longitude = 0;

  //flags
  boolean hasLocation = false;
  boolean isTracking = false;

  //on new data reception, update gps data
  public void onLocationChanged(Location location) {
    //super rough estimate: 0.009 degrees = 1 km
    latitude  = (float)location.getLatitude();
    longitude = (float)location.getLongitude();
    isTracking = true;
  }

  //on gps off, reset location
  public void onProviderDisabled (String provider) {
    latitude = 0;
    longitude = 0;
    isTracking = false;
  }

  //had to implement abstract methods from LocationListener
  public void onProviderEnabled (String provider) {
    //
  }
  public void onStatusChanged (String provider, int status, Bundle extras) {
    //
  }
}