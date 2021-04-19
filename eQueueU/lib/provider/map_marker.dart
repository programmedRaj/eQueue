import 'dart:async';
import 'dart:convert';
import 'dart:io';

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

    if (n['branch_list'] != "No branches listed yet..")
      for (int i = 0; i < n['branch_list'].length; i++) {
        branchesadd(
          address1: n['branch_list'][i]['address1'],
          address2: n['branch_list'][i]['address2'],
          bname: n['branch_list'][i]['bname'],
          bookingperday: n['branch_list'][i]['booking_per_day'],
          city: n['branch_list'][i]['city'],
          companyid: n['branch_list'][i]['comp_id'],
          countercount: n['branch_list'][i]['counter_count'],
          department: n['branch_list'][i]['department'],
          geolocation: n['branch_list'][i]['geolocation'],
          id: n['branch_list'][i]['id'],
          moneyearned: n['branch_list'][i]['money_earned'],
          notifytime: n['branch_list'][i]['notify_time'],
          perdayhours: n['branch_list'][i]['per_day_hours'],
          phonenumber: n['branch_list'][i]['phone_number'],
          postalcode: n['branch_list'][i]['postalcode'],
          profilephotourl: n['branch_list'][i]['profile_photo_url'],
          province: n['branch_list'][i]['province'],
          services: n['branch_list'][i]['services'],
          threshold: n['branch_list'][i]['threshold'],
          timezone: n['branch_list'][i]['timezone'],
          workinghours: n['branch_list'][i]['working_hours'],
        );
      }
  }

  List<BranchModel> branch = [];

  List<BranchModel> get branches => branch;

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
  }) {
    branches.add(BranchModel(
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
