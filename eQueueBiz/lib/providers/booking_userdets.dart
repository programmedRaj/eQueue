import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:equeuebiz/constants/api_constant.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingDetUserDets with ChangeNotifier {
  getbookdets(String bid, String userid, String token) async {
    var map = new Map<String, dynamic>();
    map['branch_id'] = bid;
    map['user_id'] = userid;

    var response = await retry(
      () => http
          .post(Uri.parse(BookingApi.viewbookinguserdetails),
              headers: {"Authorization": token}, body: map)
          .timeout(Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    var k = response.body;
    var n = json.decode(k);
    var tid = n['transaction_id'];

    return tid;
  }
}
