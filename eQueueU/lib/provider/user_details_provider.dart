import 'package:eQueue/api/models/userdetails.dart';
import 'package:flutter/cupertino.dart';
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:eQueue/api/service/baseurl.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

class UserDetails with ChangeNotifier {
  List<UserDets> userd = [];
  BaseUrl baseUrl = BaseUrl();
  Future getUserDet() async {
    userd.clear();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var response = await retry(
      () => http.get(
        Uri.parse(baseUrl.userdetails),
        headers: {"Authorization": token},
      ).timeout(Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    var k = response.body;
    var n = json.decode(k);

    String money = n['userdetails']['money'];
    String bonus = n['userdetails']['bonus'];
    String address1 = n['userdetails']['address1'];
    String address2 = n['userdetails']['address2'];
    String city = n['userdetails']['city'];
    String postalcode = n['userdetails']['postalcode'];
    String province = n['userdetails']['province'];

    getdet(
      name: n['userdetails']['name'],
      address1: n['userdetails']['address1'],
      address2: n['userdetails']['address2'],
      bonus: n['userdetails']['bonus'],
      city: n['userdetails']['city'],
      money: n['userdetails']['money'],
      postalcode: n['userdetails']['postalcode'],
      profileurl: n['userdetails']['profile_url'],
      province: n['userdetails']['province'],
      phone: n['userdetails']['phone_number'],
    );

    return [money, bonus, address1, address2, province, postalcode, city];
  }

  List<UserDets> get users => userd;

  getdet({
    String name,
    String profileurl,
    String address1,
    String address2,
    String province,
    String city,
    String postalcode,
    String money,
    String bonus,
    String phone,
  }) {
    users.add(UserDets(
      name: name,
      address1: address1,
      address2: address2,
      bonus: bonus,
      city: city,
      money: money,
      postalcode: postalcode,
      profileurl: profileurl,
      province: province,
      phone: phone,
    ));
    notifyListeners();
  }

  removedets() {
    users.clear();
    notifyListeners();
  }
}
