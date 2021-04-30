import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:equeuebiz/constants/api_constant.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingBranDet with ChangeNotifier {
  String bid;
  String get bids => bid;
  String bname;
  String get bnames => bname;
  getbookdets(String token) async {
    var response = await retry(
      () => http.get(
        Uri.parse(Employee.empdet),
        headers: {"Authorization": token},
      ).timeout(Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    var k = response.body;
    var n = json.decode(k);
    print('--- $n');
    bid = n['bid'];
    bname = n['bname'];
  }
}
