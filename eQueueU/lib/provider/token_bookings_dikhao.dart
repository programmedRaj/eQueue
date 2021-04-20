import 'package:eQueue/api/models/displaybooking.dart';
import 'package:eQueue/api/models/displaytoken.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:eQueue/api/service/baseurl.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';
// AIzaSyADhaiJj9t1y6YctqsK5uJr3sS3jNTl55w

class DisplayTokenBook with ChangeNotifier {
  BaseUrl baseUrl = BaseUrl();
  Future displayboth(String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    print(token);
    var map = new Map<String, dynamic>();
    map['need'] = type;

    var response = await retry(
      () => http
          .post(Uri.parse(baseUrl.displaytokenbooking),
              headers: {"Authorization": token}, body: map)
          .timeout(Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    var k = response.body;
    var n = json.decode(k);
    print(n);

    if (type == "tokens") {
      if (n["tokens"] != null) {
        removetoken();
        for (int i = 0; i < n["tokens"].length; i++) {
          addtoken(
              branchtable: n["tokens"][i]["branchtable"],
              createdon: n["tokens"][i]["created_on"],
              status: n["tokens"][i]["status"],
              token: n["tokens"][i]["token"],
              userid: n["tokens"][i]["user_id"].toString(),
              employeeid: n["tokens"][i]["employee_id"].toString(),
              slots: n["tokens"][i]["slot"],
              comp: n["tokens"][i]["comp_name"]);
        }
      }
    } else if (type == "bookings") {
      if (n["bookings"] != null) {
        removebooking();
        for (int i = 0; i < n["bookings"].length; i++) {
          addbooking(
              branchtable: n["bookings"][i]["branchtable"],
              createdon: n["bookings"][i]["created_on"],
              status: n["bookings"][i]["status"],
              booking: n["bookings"][i]["booking"],
              userid: n["bookings"][i]["user_id"].toString(),
              employeeid: n["bookings"][i]["employee_id"].toString(),
              slots: n["bookings"][i]["slot"],
              comp: n["bookings"][i]["comp_name"]);
        }
      }
    }
  }

  List<DisplayToken> tokenn = [];
  List<DisplayToken> get tokens => tokenn;
  List<DisplayBookings> booking = [];
  List<DisplayBookings> get bookings => booking;

  void addtoken({
    String token,
    String branchtable,
    String createdon,
    String status,
    String userid,
    String slots,
    String employeeid,
    String comp,
  }) {
    tokens.add(DisplayToken(
        branchtable: branchtable,
        createdon: createdon,
        status: status,
        token: token,
        userid: userid,
        employeeid: employeeid,
        slots: slots,
        comp: comp));
    notifyListeners();
  }

  void addbooking({
    String slots,
    String employeeid,
    String booking,
    String branchtable,
    String createdon,
    String status,
    String userid,
    String comp,
  }) {
    bookings.add(DisplayBookings(
        comp: comp,
        branchtable: branchtable,
        createdon: createdon,
        status: status,
        bookings: booking,
        userid: userid,
        employeeid: employeeid,
        slots: slots));
    notifyListeners();
  }

  void removetokenone({String token}) {
    tokens.removeWhere((element) => element.token == token);
    notifyListeners();
  }

  void removebookinone({String token}) {
    bookings.removeWhere((element) => element.bookings == token);
    notifyListeners();
  }

  void removetoken() {
    tokens.clear();

    notifyListeners();
  }

  void removebooking() {
    bookings.clear();

    notifyListeners();
  }
}
