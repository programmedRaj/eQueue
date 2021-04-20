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

  Future getdep({int id, int bid, String type}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var map = new Map<String, dynamic>();

    map['sortby'] = sortby;
    map['asc_desc'] = ascdsc;
    map['sorting'] = type;
    map['comp_id'] = id.toString();
    var response = await retry(
      () => http
          .post(Uri.parse(baseUrl.deletetokenbooking),
              headers: {
                "Content-Type": "application/json",
                "Authorization": token
              },
              body: bodymsg)
          .timeout(Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    var k = response.body;
    var n = json.decode(k);
  }
}
