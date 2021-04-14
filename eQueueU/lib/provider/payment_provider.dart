import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:eQueue/api/service/baseurl.dart';
import 'package:flutter/cupertino.dart';
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PayProvider with ChangeNotifier {
  BaseUrl baseUrl = BaseUrl();
  getPayment(double amount, double bonus, String tokenbooking) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var map = new Map<String, dynamic>();
    map['amount'] = amount.toString();
    map['bonus'] = bonus.toString();
    map['token_or_booking'] = tokenbooking;

    var response = await retry(
      () => http
          .post(Uri.parse(baseUrl.payment),
              headers: {"Authorization": token}, body: map)
          .timeout(Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    var k = response.body;
    var n = json.decode(k);
    var tid = n['transaction_id'];

    return tid;
  }
}
