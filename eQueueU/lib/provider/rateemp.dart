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

class Rateemp with ChangeNotifier {
  BaseUrl baseUrl = BaseUrl();
  Future displayratempboth(
      {String tokenbooking,
      String tokboknum,
      String empid,
      String ratingstar}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    print(token);
    var map = new Map<String, dynamic>();
    map['token_booking'] = tokenbooking;
    map['tok_book_num'] = tokboknum;
    map['emp_id'] = empid;
    map['ratingstars'] = ratingstar;

    var response = await retry(
      () => http
          .post(Uri.parse(baseUrl.ratemp),
              headers: {"Authorization": token}, body: map)
          .timeout(Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    var k = response.body;
    var n = json.decode(k);
    print(n);
  }
}
