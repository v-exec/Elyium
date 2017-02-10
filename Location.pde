//location listener and map provider
class Mapper implements LocationListener {
  //location coordinates
  float latitude  = 0;
  float longitude = 0;

  //coordinates to keep track of grid-based distance moved
  float recLat = 0;
  float recLon = 0;
  float unit = 2;

  //internal check variable
  boolean hasLocation = false;

  //on new data reception, update gps data
  public void onLocationChanged(Location location) {
    latitude  = (float)location.getLatitude();
    longitude = (float)location.getLongitude();

    if (dist(latitude, longitude, recLat, recLon) > unit) {
      recLat = latitude;
      recLon = longitude;
    }
  }

  //gets-sets
  public float getLatitude() {
    return latitude;
  }

  public float getLongitude() {
    return longitude;
  }

  public void setHasLocation(boolean loc) {
    hasLocation = loc;
  }

  public boolean getHasLocation() {
    return hasLocation;
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