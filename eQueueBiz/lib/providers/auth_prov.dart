import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:equeuebiz/constants/api_constant.dart';
import 'package:equeuebiz/model/auth_model.dart';
import 'package:equeuebiz/services/http_services.dart';
import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProv extends ChangeNotifier {
  AuthModel authinfo;
  bool isLoading = false;
  Future<bool> execLogin(String email, String password) async {
    print('here');
    print(email);
    print(password);
    isLoading = true;
    notifyListeners();
    var header = {
      'Content-Type': 'application/json',
      //'Authorization': Token.statToken
    };
    try {
      var resp = await httpPostRequest(AuthenticationApi.login, header,
          {"email": email, "password": password});
      // var map = {"email": email, "password": password};
      // var resp = await retry(
      //   () => http
      //       .post(Uri.parse(AuthenticationApi.login),
      //           headers: header, body: map)
      //       .timeout(Duration(seconds: 5)),
      //   retryIf: (e) => e is SocketException || e is TimeoutException,
      // );

      if (resp.statusCode == 200) {
        var decodedResp = jsonDecode(resp.body);
        print('hee ee ee $decodedResp');
        authinfo = AuthModel.fromJson(decodedResp);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('tokens', authinfo.jwtToken);

        print("token : " + authinfo.jwtToken);
        isLoading = false;
        notifyListeners();
        return true;
      } else {
        isLoading = false;
        notifyListeners();

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
