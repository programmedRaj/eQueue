import 'dart:async';

import 'package:eQueue/api/models/location_model.dart';
import 'package:location/location.dart';

class LocationService {
  Location location = Location();
  LocationM currentL;

  StreamController<LocationM> locationController =
      StreamController<LocationM>.broadcast();

  Stream<LocationM> get getStream => locationController.stream;

  LocationService() {
    location.requestPermission().then((lp) {
      if (lp == PermissionStatus.granted) {
        location.onLocationChanged.listen((locaionVal) {
          locationController.add(
              LocationM(lat: locaionVal.latitude, long: locaionVal.longitude));
        });
      }
    });
  }
}
