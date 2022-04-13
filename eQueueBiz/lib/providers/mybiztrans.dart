import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:equeuebiz/constants/api_constant.dart';
import 'package:equeuebiz/model/transactionbiz.dart';
import 'package:equeuebiz/model/viewuserbooking.dart';
import 'package:equeuebiz/services/app_toast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Biztrans with ChangeNotifier {
  biztrans(String? compid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('tokens');
    var map = new Map<String, dynamic>();
    map['comp_id'] = compid;

    var response = await retry(
      () => http
          .post(Uri.parse(CompAPi.biztrans),
              headers: {"Authorization": token as String}, body: map)
          .timeout(Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    var k = response.body;
    var n = json.decode(k);
    print(n);

    if (response.statusCode == 200) {
      removetrans();
      for (int i = 0; i < n['message'].length; i++) {
        addtb(
          amount: n['message'][i]['amount'],
          status: n['message'][i]['status'],
          txnid: n['message'][i]['txn_id'].toString(),
          userid: n['message'][i]['user_id'].toString(),
        );
      }
    } else {
      return AppToast.showErr('Something Went Wrong');
    }
  }

  List<Transbiz> tb = [];
  List<Transbiz> get trans => tb;

  void addtb({
    String? status,
    String? amount,
    String? txnid,
    String? userid,
  }) {
    trans.add(Transbiz(
      amount: amount,
      status: status,
      txnid: txnid,
      userid: userid,
    ));
    notifyListeners();
  }

  void removetrans() {
    trans.clear();
    notifyListeners();
  }
}
