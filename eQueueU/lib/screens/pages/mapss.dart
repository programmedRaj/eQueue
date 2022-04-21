import 'dart:async';

import 'package:eQueue/api/models/branchmodel.dart';
import 'package:eQueue/api/models/branchmodelcompany.dart';
import 'package:eQueue/constants/apptoast.dart';
import 'package:eQueue/provider/locationpro.dart';
import 'package:eQueue/provider/map_marker.dart';
import 'package:eQueue/screens/pages/book_appoint_service.dart';
import 'package:eQueue/screens/pages/book_token.dart';
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
  LocationData? initLoc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Location().getLocation().then((value) {
      initLoc = value;
    });
  }

  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<MapMarker>(context, listen: false).mapad();

    Provider.of<LocationProvider>(context, listen: false).initalization();
  }

  Completer<GoogleMapController> _controller = Completer();

  void onMap(
      GoogleMapController controller, List<BranchModelwithcompany> branch) {
    if (branch.length > 0) {
      for (int i = 0; i < branch.length; i++) {
        print(branch[i].geolocation);
        var geo = branch[i].geolocation!.split(',');
        var lat = geo[0];
        var long = geo[1];
        setState(() {
          _marker.add(
            Marker(
                onTap: () {
                  branch[i].type!.toLowerCase() == "booking"
                      ? Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => SelectService(
                                companyname: branch[i].company,
                                branchname: branch[i].bname,
                                bid: branch[i].id,
                                id: branch[i].companyid,
                                type: branch[i].type,
                                book: branch[i].bookingperday,
                                perday: branch[i].perdayhours,
                                wk: branch[i].workinghours,
                              )))
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Booktoken(
                                    companyname: branch[i].company,
                                    branchname: branch[i].bname,
                                    bid: branch[i].id,
                                    id: branch[i].companyid,
                                    type: branch[i].type,
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
    return Consumer<LocationProvider>(
      builder: (context, loc, child) {
        return Consumer<MapMarker>(
          builder: (context, value, child) {
            return Scaffold(
              appBar: AppBar(
                title: Text(LocaleKeys.Map).tr(),
              ),
              body: loc.locp == null
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : GoogleMap(
                      mapType: MapType.normal,
                      markers: _marker,
                      myLocationEnabled: true,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(loc.locp!.latitude, loc.locp!.longitude),
                        zoom: 14.4746,
                      ),
                      onMapCreated: (v) {
                        onMap(v, value.branches);
                      },
                    ),
            );
          },
        );
      },
    );
  }
}
