import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:eQueue/api/service/baseurl.dart';
import 'package:flutter/cupertino.dart';
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class DeletetokenProvider with ChangeNotifier {
  BaseUrl baseUrl = BaseUrl();

  Future delettoken({
    String type,
    String tokennumber,
    String branchid,
    String tokenstatus,
    String amount,
    String branchname,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var map = new Map<String, dynamic>();

    map['token_booking'] = type;
    map['number'] = tokennumber;
    map['branch_id'] = branchid;
    map['branch_name'] = branchname;
    map['tokenstatus'] = tokenstatus;
    map['amountpaid'] = '10';

    var response = await retry(
      () => http
          .post(Uri.parse(baseUrl.deletetokenbooking),
              headers: {"Authorization": token}, body: map)
          .timeout(Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    var k = response.body;
    var n = json.decode(k);
    print(n);
  }
}
