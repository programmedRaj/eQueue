import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:eQueue/constants/apptoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:eQueue/api/service/baseurl.dart';

class SendBooking with ChangeNotifier {
  BaseUrl baseUrl = BaseUrl();
  Future generatetoken({
    String branchname,
    int branchid,
    String tokenorbooking,
    String service,
    String insurance,
    String slot,
    String company,
    bool isno,
    String price,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var devicetoken = prefs.getString('devicetoken');
    print(devicetoken);
    print(
        '$branchname + $branchid + $tokenorbooking + $devicetoken + $service + $insurance + $slot + $company');
    var map = new Map<String, dynamic>();
    map['branch_name'] = branchname;
    map['branch_id'] = branchid.toString();
    map['token_or_booking'] = tokenorbooking;
    map['device_token'] = devicetoken;
    map['service'] = service;
    map['insurance'] = isno ? insurance : 'paid';
    map['slot'] = slot;
    map['comp_name'] = company;
    map['price'] = isno ? '0' : price;

    var response = await retry(
      () => http
          .post(Uri.parse(baseUrl.createtoken),
              headers: {"Authorization": token}, body: map)
          .timeout(Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    var k = response.body;
    var n = json.decode(k);
    print(n);
    if (response.statusCode == 200) {
      AppToast.showSucc('Booked Successfully');
    } else {
      AppToast.showErr('Unable to Book');
    }
  }
}
