import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:equeuebiz/constants/api_constant.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SortCheck with ChangeNotifier {
  getSortdets({
    String bid,
    String bname,
    String status,
    String userid,
    String bookingid,
    String dep,
    String dt,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('tokens');
    print(dep);

    var map = new Map<String, dynamic>();
    map['branch_id'] = bid.toString();
    map['branch_name'] = bname.toString();
    map['status'] = status;
    map['user_id'] = userid;
    map['booking_id'] = bookingid;
    map['bookingdept'] = dep;
    map['device_token'] = dt;

    var response = await retry(
      () => http
          .post(Uri.parse(BookingApi.status_check),
              headers: {"Authorization": token}, body: map)
          .timeout(Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    var k = response.body;
    var n = json.decode(k);
    print(n);
  }
}
