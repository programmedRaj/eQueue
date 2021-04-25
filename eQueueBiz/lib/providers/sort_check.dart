import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:equeuebiz/constants/api_constant.dart';
import 'package:equeuebiz/model/bookinh_model.dart';
import 'package:equeuebiz/model/branch_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SortCheck with ChangeNotifier {
  getTokendets(String bid, String bname, String token) async {
    var map = new Map<String, dynamic>();
    map['branch_id'] = bid.toString();
    map['branch_name'] = bname.toString();
    map['status'] = '';
    map['user_id'] = '';
    map['booking_id'] = '';
    map['counter_name'] = '';

    var response = await retry(
      () => http
          .post(Uri.parse(TokenApi.status_check),
              headers: {"Authorization": token}, body: map)
          .timeout(Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    var k = response.body;
    var n = json.decode(k);
    print(n);
  }
}
