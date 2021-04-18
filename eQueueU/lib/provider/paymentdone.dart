import 'package:eQueue/api/service/baseurl.dart';
import 'package:flutter/cupertino.dart';
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:eQueue/constants/apptoast.dart';
import 'package:http/http.dart' as http;

class PaymentDoneProvider with ChangeNotifier {
  BaseUrl baseUrl = BaseUrl();
  paymentdone({bool status, String amount}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var map = new Map<String, dynamic>();
    map['status'] = status.toString();
    map['amount'] = amount.toString();
    var response = await retry(
      () => http
          .post(Uri.parse(baseUrl.addmoney),
              headers: {"Authorization": token}, body: map)
          .timeout(Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    var k = response.body;
    var n = json.decode(k);
    print(n);
  }
}
