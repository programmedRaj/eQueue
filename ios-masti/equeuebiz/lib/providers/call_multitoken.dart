import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:equeuebiz/constants/api_constant.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:retry/retry.dart';

class CallMToken with ChangeNotifier {
  Future callTokeMndets(
      String bid, String bname, String token, String limit) async {
    var map = new Map<String, dynamic>();
    map['branch_id'] = bid.toString();
    map['branch_name'] = bname.toString();
    map['status'] = 'completed';
    map['limit'] = limit;

    var response = await retry(
      () => http
          .post(Uri.parse(MutliTokenApi.callmulti),
              headers: {"Authorization": token}, body: map)
          .timeout(Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    var k = response.body;
    var n = json.decode(k);
    print(n);
  }
}
