import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:eQueue/api/service/baseurl.dart';

class SendToken with ChangeNotifier {
  BaseUrl baseUrl = BaseUrl();
  Future generatetoken(
      {String branchname,
      int branchid,
      String tokenorbooking,
      String department,
      String comp}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var devicetoken = prefs.getString('devicetoken');
    print(devicetoken);
    var map = new Map<String, dynamic>();
    map['branch_name'] = branchname;
    map['branch_id'] = branchid.toString();
    map['token_or_booking'] = tokenorbooking;
    map['device_token'] = devicetoken;
    map['department'] = department;
    map['comp_name'] = comp;
    var response = await retry(
      () => http
          .post(Uri.parse(baseUrl.createtoken),
              headers: {"Authorization": token}, body: map)
          .timeout(Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    var k = response.body;
    var n = json.decode(k);
    print(n);
  }
}
