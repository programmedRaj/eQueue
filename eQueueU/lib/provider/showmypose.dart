import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:eQueue/api/service/baseurl.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShowmyPose with ChangeNotifier {
  BaseUrl baseUrl = BaseUrl();
  Future showmyPose(String tbid, String dept, String branchtable) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    print(token);
    var map = {"t_b_id": tbid, "dept": dept, "branchtable": branchtable};

    var response = await retry(
      () => http
          .post(Uri.parse(baseUrl.displaytokenbooking),
              headers: {"Authorization": token}, body: map)
          .timeout(Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    var k = response.body;
    var n = json.decode(k);
    print(n);
  }
}
