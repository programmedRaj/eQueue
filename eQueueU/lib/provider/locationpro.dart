import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationProvider with ChangeNotifier {
  Location location = Location();
  Location get loc => location;
  LatLng? lp;
  LatLng? get locp => lp;

  bool locationService = true;
  LocationProvider() {
    location = new Location();
  }
  initalization() async {
    await getUserLocation();
  }

  getUserLocation() async {
    print('hi');
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    var loca = await location.getLocation();
    print('pppp${loca.longitude}');
    location.onLocationChanged.listen((event) {
      lp = LatLng(event.latitude!, event.longitude!);
      print(lp);
      notifyListeners();
    });
  }
}
