import 'dart:convert';

import 'package:equeuebiz/constants/api_constant.dart';
import 'package:equeuebiz/model/auth_model.dart';
import 'package:equeuebiz/services/http_services.dart';
import 'package:flutter/cupertino.dart';

class AuthProv extends ChangeNotifier {
  AuthModel authinfo;
  bool isLoading = false;
  Future<bool> execLogin(String email, String password) async {
    isLoading = true;
    notifyListeners();
    var header = {
      'Content-Type': 'application/json',
      //'Authorization': Token.statToken
    };
    try {
      var resp = await httpPostRequest(AuthenticationApi.login, header,
          {"email": email, "password": password});

      if (resp.statusCode == 200) {
        var decodedResp = jsonDecode(resp.body);
        print(decodedResp);
        authinfo = AuthModel.fromJson(decodedResp);
        print("token : " + authinfo.jwtToken);
        isLoading = false;
        notifyListeners();
        return true;
      } else {
        isLoading = false;
        notifyListeners(); //hataa sab breakpoints


        //
        return false;
      }
    } catch (e) {
      isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
