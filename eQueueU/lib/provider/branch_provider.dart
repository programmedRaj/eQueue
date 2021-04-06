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
    var m = json.decode(n['branches'][0]['working_hours']);
    print(m["friday"]);
    removeedu();
    // removeday();
    if (n['branches'] != "No branches listed yet..")
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
        workinghrsperdayadd(
          monday: n['branches'][i]['working_hours']['monday'].toString(),
          friday: n['branches'][i]['working_hours']['friday'].toString(),
          saturday: n['branches'][i]['working_hours']['saturday'].toString(),
          sunday: n['branches'][i]['working_hours']['sunday'].toString(),
          thursday: n['branches'][i]['working_hours']['thrusday'].toString(),
          tuesday: n['branches'][i]['working_hours']['tuesday'].toString(),
          wednesday: n['branches'][i]['working_hours']['wednesday'].toString(),
        );
        bookinghrsperdayadd(
          monday: n['branches'][i]['booking_per_day']['monday'].toString(),
          friday: n['branches'][i]['booking_per_day']['friday'].toString(),
          saturday: n['branches'][i]['booking_per_day']['saturday'].toString(),
          sunday: n['branches'][i]['booking_per_day']['sunday'].toString(),
          thursday: n['branches'][i]['booking_per_day']['thrusday'].toString(),
          tuesday: n['branches'][i]['booking_per_day']['tuesday'].toString(),
          wednesday:
              n['branches'][i]['booking_per_day']['wednesday'].toString(),
        );
        perdayadd(
          monday: n['branches'][i]['per_day_hours']['monday'].toString(),
          friday: n['branches'][i]['per_day_hours']['friday'].toString(),
          saturday: n['branches'][i]['per_day_hours']['saturday'].toString(),
          sunday: n['branches'][i]['per_day_hours']['sunday'].toString(),
          thursday: n['branches'][i]['per_day_hours']['thrusday'].toString(),
          tuesday: n['branches'][i]['per_day_hours']['tuesday'].toString(),
          wednesday: n['branches'][i]['per_day_hours']['wednesday'].toString(),
        );
      }
  }

  List<BranchModel> branch = [];

  List<BranchModel> get branches => branch;
  List<Workinghrsperday> workinghrs = [];
  List<Workinghrsperday> get workinghrsper => workinghrs;

  List<Workinghrsperday> bookingshrs = [];
  List<Workinghrsperday> get bookingsperhrs => bookingshrs;

  List<Workinghrsperday> perdayhrs = [];

  List<Workinghrsperday> get perdayhrss => perdayhrs;

  void workinghrsperdayadd({
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
    String sunday,
  }) {
    workinghrsper.add(Workinghrsperday(
      friday: friday,
      monday: monday,
      saturday: saturday,
      sunday: sunday,
      thursday: thursday,
      tuesday: tuesday,
      wednesday: wednesday,
    ));
  }

  void bookinghrsperdayadd({
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
    String sunday,
  }) {
    bookingsperhrs.add(Workinghrsperday(
      friday: friday,
      monday: monday,
      saturday: saturday,
      sunday: sunday,
      thursday: thursday,
      tuesday: tuesday,
      wednesday: wednesday,
    ));
  }

  void perdayadd({
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
    String sunday,
  }) {
    perdayhrss.add(Workinghrsperday(
      friday: friday,
      monday: monday,
      saturday: saturday,
      sunday: sunday,
      thursday: thursday,
      tuesday: tuesday,
      wednesday: wednesday,
    ));
  }

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
  // }
}
