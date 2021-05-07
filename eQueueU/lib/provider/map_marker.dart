import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:eQueue/api/models/branchmodelcompany.dart';
import 'package:http/http.dart' as http;
import 'package:eQueue/api/models/branchmodel.dart';
import 'package:eQueue/api/service/baseurl.dart';
import 'package:flutter/cupertino.dart';
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MapMarker with ChangeNotifier {
  BaseUrl baseUrl = BaseUrl();
  mapad() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var response = await retry(
      () => http.get(Uri.parse(baseUrl.addmap), headers: {
        // "Content-Type": "application/json",
        "Authorization": token
      }).timeout(Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    var k = response.body;
    var n = json.decode(k);

    removeedu();

    for (int i = 0; i < n['address1'].length; i++) {
      branchesadd(
        address1: n['address1'][i],
        address2: n['address2'][i],
        bname: n['bname'][i],
        bookingperday: n['booking_per_day'][i],
        city: n['city'][i],
        companyid: n['comp_id'][i],
        countercount: n['counter_count'][i],
        department: n['department'][i],
        geolocation: n['geolocation'][i],
        id: n['branch_id'][i],
        moneyearned: n['money_earned'][i],
        notifytime: n['notify_time'][i],
        perdayhours: n['per_day_hours'][i],
        phonenumber: n['phone_number'][i],
        postalcode: n['postalcode'][i],
        profilephotourl: n['profile_photo_url'][i],
        province: n['province'][i],
        services: n['services'][i],
        threshold: n['threshold'][i],
        timezone: n['timezone'][i],
        workinghours: n['working_hours'][i],
        company: n['comp_name'][i],
        type: n['comp_type'][i],
      );
    }
  }

  List<BranchModelwithcompany> branch = [];

  List<BranchModelwithcompany> get branches => branch;

  void branchesadd({
    int id,
    int companyid,
    String address1,
    String address2,
    String bname,
    String bookingperday,
    String city,
    String countercount,
    String department,
    String geolocation,
    String moneyearned,
    String notifytime,
    String perdayhours,
    String phonenumber,
    String postalcode,
    String profilephotourl,
    String province,
    String services,
    String threshold,
    String timezone,
    String workinghours,
    String company,
    String type,
  }) {
    branches.add(BranchModelwithcompany(
        company: company,
        type: type,
        address1: address1,
        address2: address2,
        bname: bname,
        bookingperday: bookingperday,
        city: city,
        companyid: companyid,
        countercount: countercount,
        department: department,
        geolocation: geolocation,
        id: id,
        moneyearned: moneyearned,
        notifytime: notifytime,
        perdayhours: perdayhours,
        phonenumber: phonenumber,
        postalcode: postalcode,
        profilephotourl: profilephotourl,
        province: province,
        services: services,
        threshold: threshold,
        timezone: timezone,
        workinghours: workinghours));
    notifyListeners();
  }

  void removeedu() {
    branches.clear();
    notifyListeners();
  }

  // void removeday() {
  //   workinghrsper.clear();
  //   bookingsperhrs.clear();
  //   perdayhrss.clear();
  //   notifyListeners();
}
