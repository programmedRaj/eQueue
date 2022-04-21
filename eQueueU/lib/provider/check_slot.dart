import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:eQueue/api/models/bookingslot.dart';
import 'package:eQueue/api/service/baseurl.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SlotProvider extends ChangeNotifier {
  BaseUrl baseUrl = BaseUrl();

  Future getslot({String? name, int? bid, String? type}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var map = new Map<String, dynamic>();
    map['branch_name'] = name;
    map['branch_id'] = bid.toString();
    map['token_or_booking'] = type;

    var response = await retry(
      () => http
          .post(Uri.parse(baseUrl.checkslot),
              headers: {"Authorization": token!}, body: map)
          .timeout(Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    var k = response.body;
    var n = json.decode(k);
    print(n);
    print(response.statusCode);

    removeedu();
    if (n['bookings'] != null)
      for (int i = 0; i < n['bookings'].length; i++) {
        slotsadd(
            date: n['bookings'][i]["slots"]
                .split(' -')[0]
                .replaceAll(new RegExp(r"\s+"), ""),
            time: n['bookings'][i]["slots"]
                .split(' -')[1]
                .replaceAll(new RegExp(r"\s+"), ""));
      }
  }

  List<BookingSlot> booking = [];

  List<BookingSlot> get bookings => booking;

  void slotsadd({
    String? date,
    String? time,
  }) {
    bookings.add(BookingSlot(date: date, time: time));
    notifyListeners();
  }

  void removeedu() {
    bookings.clear();
    notifyListeners();
  }
}
