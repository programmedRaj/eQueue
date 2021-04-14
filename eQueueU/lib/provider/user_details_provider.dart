import 'package:flutter/cupertino.dart';
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:eQueue/api/service/baseurl.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

class UserDetails with ChangeNotifier {
  BaseUrl baseUrl = BaseUrl();
  getUserDet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var response = await retry(
      () => http.post(
        Uri.parse(baseUrl.userdetails),
        headers: {"Authorization": token},
      ).timeout(Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    var k = response.body;
    var n = json.decode(k);
    print(n);
  }
}
