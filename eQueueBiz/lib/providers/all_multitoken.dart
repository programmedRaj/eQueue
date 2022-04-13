import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:equeuebiz/constants/api_constant.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:retry/retry.dart';

class AllMToken with ChangeNotifier {
  int? totalM;
  int? get totalMm => totalM;
  Future getTokeMndets(String bid, String? bname, String? token) async {
    var map = new Map<String, dynamic>();
    map['branch_id'] = bid.toString();
    map['branch_name'] = bname.toString();

    var response = await retry(
      () => http
          .post(Uri.parse(MutliTokenApi.allmulti),
              headers: {"Authorization": token!}, body: map)
          .timeout(Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    var k = response.body;
    var n = json.decode(k);
    print(n['tokens']);
    return n['tokens'];
  }
}
