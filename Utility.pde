public void onResume() {
  super.onResume();
  
  //re-render visuals
  if (UI != null) UI.setRendered(false);
}

public void onPause() {
  super.onPause();
}

//setup location sensor when permission is granted by user (and check if location can be read)
void onPermissionsGranted() {
  LocationManager locManager;

  if (checkPermission(Manifest.permission.ACCESS_FINE_LOCATION) || checkPermission(Manifest.permission.ACCESS_COARSE_LOCATION)) {
    Context locContext = getActivity();
    mapper = new Mapper();
    locManager = (LocationManager)locContext.getSystemService(Context.LOCATION_SERVICE); 
    locManager.requestLocationUpdates(LocationManager.NETWORK_PROVIDER, 0, 0, mapper);
    mapper.setHasLocation(true);
  } else {
    mapper.setHasLocation(false);
  }
}