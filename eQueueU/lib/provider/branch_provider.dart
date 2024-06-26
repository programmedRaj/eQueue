import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:eQueue/api/models/branchmodel.dart';
import 'package:eQueue/api/models/companymodel.dart';
import 'package:eQueue/api/models/working_per_day.dart';
import 'package:eQueue/api/service/baseurl.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BranchProvider extends ChangeNotifier {
  BaseUrl baseUrl = BaseUrl();

  Future getBranches(
      {int? id, required bool sort, String? sortby, String? ascdsc, String? type}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var map = new Map<String, dynamic>();
    if (sort) {
      map['sortby'] = sortby;
      map['asc_desc'] = ascdsc;
      map['sorting'] = type;
      map['comp_id'] = id.toString();
    }

    var bodymsg = json.encode({"company_id": id});
    var response = await retry(
      () => http
          .post(
              sort
                  ? Uri.parse(baseUrl.sorting)
                  : Uri.parse(baseUrl.branch_list),
              headers: sort
                  ? {
                      // "Content-Type": "application/json",
                      "Authorization": token!
                    }
                  : {
                      "Content-Type": "application/json",
                      "Authorization": token!
                    },
              body: sort ? map : bodymsg)
          .timeout(Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    var k = response.body;
    var n = json.decode(k);

    removeedu();

    if (n['branches'] != "No branches listed yet..")
      for (int i = 0; i < n['branches'].length; i++) {
        branchesadd(
          address1: n['branches'][i]['address1'],
          address2: n['branches'][i]['address2'],
          bname: n['branches'][i]['bname'],
          bdesc: n['branches'][i]['bdescription'],
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
        // if (type == 'booking') {
        // var wh = json.decode(n['branches'][0]['working_hours']);
        // var book = json.decode(n['branches'][0]['booking_per_day']);
        // var perday = json.decode(n['branches'][0]['per_day_hours']);

        //   workingadd(day: 'monday', time: wh['Monday'].toString());
        //   workingadd(day: 'tuesday', time: wh['Tuesday'].toString());
        //   workingadd(day: 'wednesday', time: wh['Wednesday'].toString());
        //   workingadd(day: 'thursday', time: wh['Thursday'].toString());
        //   workingadd(day: 'friday', time: wh['Friday'].toString());
        //   workingadd(day: 'saturday', time: wh['Saturday'].toString());
        //   workingadd(day: 'sunday', time: wh['Sunday'].toString());

        //   bookinghrsperdayadd(day: 'monday', value: book[0].toString());
        //   bookinghrsperdayadd(day: 'tuesday', value: book[1].toString());
        //   bookinghrsperdayadd(day: 'wednesday', value: book[2].toString());
        //   bookinghrsperdayadd(day: 'thursday', value: book[3].toString());
        //   bookinghrsperdayadd(day: 'friday', value: book[4].toString());
        //   bookinghrsperdayadd(day: 'saturday', value: book[5].toString());
        //   bookinghrsperdayadd(day: 'sunday', value: book[6].toString());

        //   perdayadd(day: 'monday', value: perday[0].toString());
        //   perdayadd(day: 'tuesday', value: perday[1].toString());
        //   perdayadd(day: 'wednesday', value: perday[2].toString());
        //   perdayadd(day: 'thursday', value: perday[3].toString());
        //   perdayadd(day: 'friday', value: perday[4].toString());
        //   perdayadd(day: 'saturday', value: perday[5].toString());
        //   perdayadd(day: 'sunday', value: perday[6].toString());
        // }
      }
  }

  List<BranchModel> branch = [];

  List<BranchModel> get branches => branch;
  // List<Working> workinghrs = [];
  // List<Working> get workinghrsper => workinghrs;

  // List<Working> bookingshrs = [];
  // List<Working> get bookingsperhrs => bookingshrs;

  // List<Working> perdayhrs = [];

  // List<Working> get perdayhrss => perdayhrs;

  // void workingadd({String day, String time}) {
  //   workinghrsper.add(Working(day: day, value: time));
  //   print(workinghrsper);
  // }

  // void bookinghrsperdayadd({
  //   String day,
  //   String value,
  // }) {
  //   bookingsperhrs.add(Working(day: day, value: value));
  // }

  // void perdayadd({
  //   String day,
  //   String value,
  // }) {
  //   perdayhrss.add(Working(day: day, value: value));
  // }

  void branchesadd({
    int? id,
    int? companyid,
    String? address1,
    String? address2,
    String? bname,
    String? bdesc,
    String? bookingperday,
    String? city,
    String? countercount,
    String? department,
    String? geolocation,
    String? moneyearned,
    String? notifytime,
    String? perdayhours,
    String? phonenumber,
    String? postalcode,
    String? profilephotourl,
    String? province,
    String? services,
    String? threshold,
    String? timezone,
    String? workinghours,
  }) {
    branches.add(BranchModel(
        address1: address1,
        address2: address2,
        bname: bname,
        bdesc: bdesc,
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
  // }
}
