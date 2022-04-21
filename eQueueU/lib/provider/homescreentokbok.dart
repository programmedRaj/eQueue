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

class DisplayTokenBookHome with ChangeNotifier {
  BaseUrl baseUrl = BaseUrl();
  Future displayboth(String type, String where) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var map = new Map<String, dynamic>();
    map['need'] = type;
    map['where'] = where;

    var response = await retry(
      () => http
          .post(Uri.parse(baseUrl.homescreendisplay),
              headers: {"Authorization": token!}, body: map)
          .timeout(Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    var k = response.body;
    var n = json.decode(k);
    print(n);
    if (n['message'] == 'No bookings found') {
      removebooking();
    }

    if (n['message'] == 'No tokens found') {
      removetoken();
    }

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
              comp: n["tokens"][i]["comp_name"],
              countno: n["tokens"][i]["counter_number"],
              wait: n["waitlist"][i].toString());
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
            comp: n["bookings"][i]["comp_name"],
            price: n["bookings"][i]["price"],
            // wait: n["waitlist"].length > 0 || n["waitlist"] != null
            //     ? n["waitlist"][i].toString()
            //     : '0'
          );
        }
      }
    }
  }

  List<DisplayToken> tokenn = [];
  List<DisplayToken> get tokens => tokenn;
  List<DisplayBookings> booking = [];
  List<DisplayBookings> get bookings => booking;

  void addtoken({
    String? token,
    String? branchtable,
    String? createdon,
    String? status,
    String? userid,
    String? slots,
    String? employeeid,
    String? comp,
    String? wait,
    String? countno,
  }) {
    tokens.add(DisplayToken(
        countnum: countno,
        branchtable: branchtable,
        createdon: createdon,
        status: status,
        token: token,
        userid: userid,
        employeeid: employeeid,
        slots: slots,
        waitlist: wait,
        comp: comp));
    notifyListeners();
  }

  void addbooking({
    String? slots,
    String? employeeid,
    String? booking,
    String? branchtable,
    String? createdon,
    String? status,
    String? userid,
    String? comp,
    String? wait,
    String? price,
  }) {
    bookings.add(DisplayBookings(
      price: price,
      comp: comp,
      branchtable: branchtable,
      createdon: createdon,
      status: status,
      bookings: booking,
      userid: userid,
      employeeid: employeeid,
      slots: slots,
      // waitlist: wait,
    ));

    notifyListeners();
  }

  void removetokenone({String? token}) {
    tokens.removeWhere((element) => element.token == token);
    notifyListeners();
  }

  void removebookinone({String? token}) {
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
