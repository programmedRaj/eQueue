import 'dart:convert';

import 'package:equeuebiz/constants/api_constant.dart';
import 'package:equeuebiz/services/http_services.dart';

class ChangePassProv {
  Future<bool> execChangePass(
      String token, String currentPass, String newPass) async {
    var header = {'Content-Type': 'application/json', 'Authorization': token};
    try {
      var resp = await httpPostRequest(AuthenticationApi.changePassword, header,
          {"password": currentPass, "new_password": newPass});

      if (resp.statusCode == 200) {
        var decodedResp = jsonDecode(resp.body);
        print(decodedResp);
        return true;
      } else {
        print(jsonDecode(resp.body));
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
