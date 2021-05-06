import 'dart:async';

import 'package:eQueue/api/models/branchmodel.dart';
import 'package:eQueue/api/models/branchmodelcompany.dart';
import 'package:eQueue/constants/apptoast.dart';
import 'package:eQueue/provider/map_marker.dart';
import 'package:eQueue/screens/pages/book_appoint_service.dart';
import 'package:eQueue/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:location/location.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Set<Marker> _marker = {};

  LocationData _currentPosition;
  String _address, _dateTime;
  // GoogleMapController mapController;
  // Marker marker;
  Location location = Location();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLoc();
  }

  getLoc() async {
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

    _currentPosition = await location.getLocation();
    // _initialcameraposition = LatLng(_currentPosition.latitude,_currentPosition.longitude);
    location.onLocationChanged.listen((LocationData currentLocation) {
      print(" abc ${currentLocation.longitude} : ${currentLocation.longitude}");
      setState(() {
        _currentPosition = currentLocation;
        // _initialcameraposition = LatLng(_currentPosition.latitude,_currentPosition.longitude);

        DateTime now = DateTime.now();
        _dateTime = DateFormat('EEE d MMM kk:mm:ss ').format(now);
        print('${_currentPosition.longitude}');
        // _getAddress(_currentPosition.latitude, _currentPosition.longitude)
        //     .then((value) {
        //   setState(() {
        //     _address = "${value.first.addressLine}";
        //   });
        // });
      });
    });
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<MapMarker>(context, listen: false).mapad();
  }

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  void onMap(
      GoogleMapController controller, List<BranchModelwithcompany> branch) {
    if (branch.length > 0) {
      for (int i = 0; i < branch.length; i++) {
        print(branch[i].geolocation);
        var geo = branch[i].geolocation.split(',');
        var lat = geo[0];
        var long = geo[1];
        setState(() {
          _marker.add(
            Marker(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => SelectService(
                            companyname: branch[i].company,
                            branchname: branch[i].bname,
                            bid: branch[i].id,
                            id: branch[i].companyid,
                            type: branch[i].type,
                            book: branch[i].bookingperday,
                            perday: branch[i].perdayhours,
                            wk: branch[i].workinghours,
                          )));
                },
                infoWindow: InfoWindow(
                  title: branch[i].bname,
                  snippet: branch[i].city,
                ),
                markerId: MarkerId(branch[i].id.toString()),
                position: LatLng(
                  double.parse(lat),
                  double.parse(long),
                )),
          );
        });
      }
    } else {
      AppToast.showErr(LocaleKeys.nobranches.tr());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MapMarker>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(LocaleKeys.Map).tr(),
          ),
          body: GoogleMap(
            mapType: MapType.normal,
            markers: _marker,
            initialCameraPosition: CameraPosition(
              target: LatLng(37.42796133580664, -122.085749655962),
              zoom: 14.4746,
            ),
            onMapCreated: (v) {
              onMap(v, value.branches);
            },
          ),
        );
      },
    );
  }
}

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:location/location.dart';
// // import 'package:geocoder/geocoder.dart';
// import 'package:intl/intl.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class MyLocation extends StatefulWidget {
//   @override
//   _MyLocationState createState() => _MyLocationState();
// }

// class _MyLocationState extends State<MyLocation> {
//   LocationData _currentPosition;
//   String _address, _dateTime;
//   GoogleMapController mapController;
//   Marker marker;
//   Location location = Location();

//   GoogleMapController _controller;
//   LatLng _initialcameraposition = LatLng(0.5937, 0.9629);

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getLoc();
//   }

//   void _onMapCreated(GoogleMapController _cntlr) {
//     _controller = _controller;
//     location.onLocationChanged.listen((l) {
//       _controller.animateCamera(
//         CameraUpdate.newCameraPosition(
//           CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 15),
//         ),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage('assets/images/bg.jpg'), fit: BoxFit.cover),
//         ),
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: SafeArea(
//           child: Container(
//             color: Colors.blueGrey.withOpacity(.8),
//             child: Center(
//               child: Column(
//                 children: [
//                   Container(
//                     height: MediaQuery.of(context).size.height / 2.5,
//                     width: MediaQuery.of(context).size.width,
//                     child: GoogleMap(
//                       initialCameraPosition: CameraPosition(
//                           target: _initialcameraposition, zoom: 15),
//                       mapType: MapType.normal,
//                       onMapCreated: _onMapCreated,
//                       myLocationEnabled: true,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 3,
//                   ),
//                   if (_dateTime != null)
//                     Text(
//                       "Date/Time: $_dateTime",
//                       style: TextStyle(
//                         fontSize: 15,
//                         color: Colors.white,
//                       ),
//                     ),
//                   SizedBox(
//                     height: 3,
//                   ),
//                   if (_currentPosition != null)
//                     Text(
//                       "Latitude: ${_currentPosition.latitude}, Longitude: ${_currentPosition.longitude}",
//                       style: TextStyle(
//                           fontSize: 22,
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   SizedBox(
//                     height: 3,
//                   ),
//                   if (_address != null)
//                     Text(
//                       "Address: $_address",
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.white,
//                       ),
//                     ),
//                   SizedBox(
//                     height: 3,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   getLoc() async {
//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;

//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         return;
//       }
//     }

//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }

//     _currentPosition = await location.getLocation();
//     _initialcameraposition =
//         LatLng(_currentPosition.latitude, _currentPosition.longitude);
//     location.onLocationChanged.listen((LocationData currentLocation) {
//       print(
//           "gggggggggggg${currentLocation.longitude} : ${currentLocation.longitude}");
//       setState(() {
//         _currentPosition = currentLocation;
//         _initialcameraposition =
//             LatLng(_currentPosition.latitude, _currentPosition.longitude);

//         DateTime now = DateTime.now();
//         _dateTime = DateFormat('EEE d MMM kk:mm:ss ').format(now);
//         // _getAddress(_currentPosition.latitude, _currentPosition.longitude)
//         //     .then((value) {
//         //   setState(() {
//         //     _address = "${value.first.addressLine}";
//         //   });
//         // });
//       });
//     });
//   }

//   // Future<List<Address>> _getAddress(double lat, double lang) async {
//   //   final coordinates = new Coordinates(lat, lang);
//   //   List<Address> add =
//   //   await Geocoder.local.findAddressesFromCoordinates(coordinates);
//   //   return add;
//   // }

// }
