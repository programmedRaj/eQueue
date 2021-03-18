import 'dart:convert';

import 'package:equeuebiz/constants/api_constant.dart';
import 'package:equeuebiz/services/http_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgotPassProv extends ChangeNotifier {
  bool isLoading = false;
  bool error = false;
  bool vanishEmail = false;
  Future<bool> execForgotPassSndOtp(String email) async {
    isLoading = true;
    notifyListeners();
    var header = {
      'Content-Type': 'application/json',
      //'Authorization': Token.statToken
    };
    try {
      var resp = await httpPostRequest(AuthenticationApi.forgotPass, header, {
        "email": email,
      });

      if (resp.statusCode == 200) {
        var decodedResp = jsonDecode(resp.body);
        vanishEmail = true;
        print("opt" + decodedResp["otp"]);
        notifyListeners();
        return true;
      } else {
        isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> execChangeForgotPassSndOtp(
      String email, String otp, String newPass) async {
    isLoading = true;
    notifyListeners();
    var header = {
      'Content-Type': 'application/json',
      //'Authorization': Token.statToken
    };
    try {
      var resp = await httpPostRequest(AuthenticationApi.changeForgotPass,
          header, {"email": email, "otp": otp, "new_passw": newPass});

      if (resp.statusCode == 200) {
        var decodedResp = jsonDecode(resp.body);
        isLoading = false;
        notifyListeners();
        return true;
      } else {
        isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
