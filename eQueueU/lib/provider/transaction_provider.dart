import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:eQueue/api/models/transactionmodel.dart';
import 'package:eQueue/api/service/baseurl.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';

class TransactionProvider with ChangeNotifier {
  BaseUrl baseUrl = BaseUrl();
  Future displaytrans() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var response = await retry(
      () => http.get(
        Uri.parse(baseUrl.transactions),
        headers: {"Authorization": token!},
      ).timeout(Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    var k = response.body;
    var n = json.decode(k);
    removetoken();
    for (int i = 0; i < n['message'].length; i++) {
      addtoken(
        tid: n['message'][i]['txn_id'],
        amount: n['message'][i]['amount'],
        color: n['message'][i]['color'],
        status: n['message'][i]['status'],
        userid: n['message'][i]['user_id'],
      );
    }
  }

  List<TransactionModel> tran = [];
  List<TransactionModel> get trans => tran;

  void addtoken({
    String? amount,
    String? color,
    int? tid,
    String? status,
    int? userid,
  }) {
    trans.add(TransactionModel(
      amount: amount,
      color: color,
      status: status,
      tid: tid,
      uid: userid,
    ));
    notifyListeners();
  }

  void removetoken() {
    trans.clear();

    notifyListeners();
  }
}
