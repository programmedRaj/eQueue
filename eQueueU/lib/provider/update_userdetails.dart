import 'package:eQueue/api/models/userdetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:eQueue/api/service/baseurl.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

class UpUserDetails with ChangeNotifier {
  BaseUrl baseUrl = BaseUrl();
  Future upUserDet(
    File images,
    String address1,
    String address2,
    String city,
    String postalcode,
    String province,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    Uri registeruri = Uri.parse(baseUrl.updateuserdetails);
    var header = {
      'Content-Type': 'multipart/form-data',
      'Authorization': token,
    };

    var request = new http.MultipartRequest("POST", registeruri)
      ..headers.addAll(header);
    if (images != null) {
      request.files
          .add(await http.MultipartFile.fromPath('profile_img', images.path));
    } else {
      request.files
          .add(http.MultipartFile.fromBytes('profile_img', [], filename: ''));
    }
    request.fields['address1'] =
        address1 == null || address1.isEmpty ? "optional" : address1;
    request.fields['address2'] =
        address2 == null || address2.isEmpty ? "optional" : address2;
    request.fields['province'] =
        province == null || province.isEmpty ? "optional" : province;
    request.fields['city'] = city == null || city.isEmpty ? "optional" : city;
    request.fields['postalcode'] =
        postalcode == null || postalcode.isEmpty ? "optional" : postalcode;
    var res = await request.send();

    var response = await http.Response.fromStream(res);
    print(jsonDecode(response.body));
  }
}
