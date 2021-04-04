import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:eQueue/api/models/branchmodel.dart';
import 'package:eQueue/api/models/companymodel.dart';
import 'package:eQueue/api/service/baseurl.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BranchProvider extends ChangeNotifier {
  BaseUrl baseUrl = BaseUrl();

  Future getBranches(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var bodymsg = json.encode({"company_id": id});
    var response = await retry(
      () => http
          .post(Uri.parse(baseUrl.branch_list),
              headers: {
                "Content-Type": "application/json",
                "Authorization": token
              },
              body: bodymsg)
          .timeout(Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    var k = response.body;
    var n = json.decode(k);
    print(n);

    for (int i = 0; i < n['branches'].length; i++) {
      branchesadd(
        address1: n['branches'][i]['address1'],
        address2: n['branches'][i]['address2'],
        bname: n['branches'][i]['bname'],
        bookingperday: n['branches'][i]['booking_per_day'],
        city: n['branches'][i]['city'],
        companyid: n['branches'][i]['comp_id'],
        countercount: n['branches'][i]['counter_count'],
        department: n['branches'][i]['department'],
        geolocation: n['branches'][i]['geolocation'],
        id: n['branches'][i]['id'],
        moneyearned: n['branches'][i]['money_earned'],
        notifytime: n['branches'][i]['notify_time'],
        perdayhours: n['branches'][i]['per_day_hours'],
        phonenumber: n['branches'][i]['phone_number'],
        postalcode: n['branches'][i]['postalcode'],
        profilephotourl: n['branches'][i]['profile_photo_url'],
        province: n['branches'][i]['province'],
        services: n['branches'][i]['services'],
        threshold: n['branches'][i]['threshold'],
        timezone: n['branches'][i]['timezone'],
        workinghours: n['branches'][i]['working_hours'],
      );
    }
    removeedu();
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
}
