import 'dart:convert';

import 'package:equeue_admin/constants/api_constants.dart';
import 'package:equeue_admin/services/http_services.dart';
import 'package:flutter/cupertino.dart';

class LoginProv extends ChangeNotifier {
  String jwtToken;
  bool isError = false;
  bool success = false;

  executeLogin(String email, String password) async {
    try {
      var resp = await httpPostRequest(LoginApi.loginUrl, {
        'Content-Type': 'application/json',
      }, {
        "email": email,
        "password": password
      });

      if (resp.statusCode == 200) {
        var decodedResp = jsonDecode(resp.body);
        if (decodedResp["message"] == true) {
          jwtToken = decodedResp["token"];
          print(jwtToken);
          success = true;
          notifyListeners();
        } else {
          isError = true;
          notifyListeners();
        }
      } else {
        isError = true;
        notifyListeners();
      }
    } catch (e) {
      isError = true;
      notifyListeners();
    }
  }

  notifyListeners();
}
