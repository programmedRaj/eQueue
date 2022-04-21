import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:eQueue/api/service/baseurl.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DepProvider extends ChangeNotifier {
  BaseUrl baseUrl = BaseUrl();

  Future getdep({int? id, int? bid, String? type}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var bodymsg =
        json.encode({"company_id": id, "branch_id": bid, "comp_type": type});
    var response = await retry(
      () => http
          .post(Uri.parse(baseUrl.departments),
              headers: {
                "Content-Type": "application/json",
                "Authorization": token!
              },
              body: bodymsg)
          .timeout(Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    var k = response.body;
    var n = json.decode(k);
    print(n);
    print(n['departments'][0]);

    removeedu();
    if (n['departments'] != "Error.")
      for (int i = 0; i < n['departments'].length; i++) {
        branchesadd(deps: n['departments'][i]);
      }
  }

  List<String?> depart = [];

  List<String?> get departs => depart;

  void branchesadd({
    String? deps,
  }) {
    departs.add(deps);
    notifyListeners();
  }

  void removeedu() {
    departs.clear();
    notifyListeners();
  }
}
