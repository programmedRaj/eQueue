import 'dart:convert';

import 'package:equeue_admin/constants/api_constants.dart';
import 'package:equeue_admin/services/http_services.dart';
import 'package:equeue_admin/services/sp.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProv extends ChangeNotifier {
  String jwtToken;
  bool isError = false;
  bool success = false;

  Future<bool> executeLogin(String email, String password) async {
    try {
      isError = false;
      success = false;
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
          SP().storeEmail(email);
          SP().storePass(password);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('token', jwtToken);
          print(jwtToken);
          success = true;
          notifyListeners();
          return success;
        } else {
          isError = true;
          notifyListeners();
          return false;
        }
      } else {
        isError = true;
        notifyListeners();
        return false;
      }
    } catch (e) {
      isError = true;
      notifyListeners();
      return false;
    }
  }

  logOut() {
    jwtToken = null;
    success = false;
  }
}
