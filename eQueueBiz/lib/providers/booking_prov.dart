import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:equeuebiz/constants/api_constant.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingDet with ChangeNotifier {
  getbookdets(String bid, String bname, String date, String token) async {
    var map = new Map<String, dynamic>();
    map['branch_id'] = bid.toString();
    map['branch_name'] = bname.toString();
    map['date_sort'] = date.toString();

    var response = await retry(
      () => http
          .post(Uri.parse(BookingApi.bookingdetails),
              headers: {"Authorization": token}, body: map)
          .timeout(Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    var k = response.body;
    var n = json.decode(k);
    bro tu karle phele fir me karta hu heelooooooooobitch
    mee aake karegaa
    jaa raha huu
  }
}
