import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:eQueue/constants/apptoast.dart';
import 'package:http/http.dart' as http;
import 'package:eQueue/api/service/baseurl.dart';
import 'package:flutter/cupertino.dart';
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenChecker with ChangeNotifier {
  BaseUrl baseUrl = BaseUrl();

  Future checkToken(
      {String branchname, int branchid, String tokenorbooking}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    print(tokenorbooking);

    var map = new Map<String, dynamic>();
    map['branch_name'] = branchname;
    map['branch_id'] = branchid.toString();
    map['token_or_booking'] =
        tokenorbooking == 'multitoken' ? 'token' : tokenorbooking;

    var response = await retry(
      () => http
          .post(Uri.parse(baseUrl.tb_check),
              headers: {"Authorization": token}, body: map)
          .timeout(Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    var k = response.body;
    var n = json.decode(k);
    print(n);
    if (response.statusCode == 200) {
      return response.statusCode;
    } else {
      AppToast.showErr("You already have token of this branch");
      return 403;
    }
  }
}
