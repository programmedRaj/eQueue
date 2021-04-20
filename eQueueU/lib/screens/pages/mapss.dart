import 'dart:async';

import 'package:eQueue/api/models/branchmodel.dart';
import 'package:eQueue/api/models/branchmodelcompany.dart';
import 'package:eQueue/constants/apptoast.dart';
import 'package:eQueue/provider/map_marker.dart';
import 'package:eQueue/screens/pages/book_appoint_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapSample extends StatefulWidget {
  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  Set<Marker> _marker = {};
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
      AppToast.showErr('No Branches');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MapMarker>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Map'),
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
