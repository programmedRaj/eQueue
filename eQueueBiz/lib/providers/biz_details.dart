import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:equeuebiz/constants/api_constant.dart';
import 'package:equeuebiz/model/bizdetsmo.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BizUserDets with ChangeNotifier {
  int? counterbranches;
  int? get counterbranchess => counterbranches;
  int? counteremps;
  int? get counterempss => counteremps;
  String? cname;
  String? get cn => cname;

  getBizUserdets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.get('tokens');
    print(token);

    var response = await retry(
      () => http.get(
        Uri.parse(CompAPi.getbizdets),
        headers: {"Authorization": token as String},
      ).timeout(Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    var k = response.body;
    var n = json.decode(k);
    print(n);
    counterbranches = n['counterbranches'];
    counteremps = n['counteremps'];
    cname = n['cname'];
    removedd();
    addets(
      acn: n['details']['account_name'],
      acnum: n['details']['account_number'],
      bname: n['details']['bankname'],
      descr: n['details']['descr'],
      earned: n['details']['earned_till_date'],
      id: n['details']['id'].toString(),
      ifsc: n['details']['ifsc'],
      moneyearned: n['details']['money_earned'],
      name: n['details']['name'],
      profileurl: n['details']['profile_url'],
      type: n['details']['type'],
    );
  }

  List<BizDets> s = [];
  List<BizDets> get ss => s;

  void addets({
    String? acn,
    String? acnum,
    String? bname,
    String? descr,
    String? earned,
    String? id,
    String? ifsc,
    String? moneyearned,
    String? name,
    String? profileurl,
    String? type,
  }) {
    ss.add(BizDets(
        acn: acn,
        acnum: acnum,
        bname: bname,
        descr: descr,
        earned: earned,
        id: id,
        ifsc: ifsc,
        moneyearned: moneyearned,
        name: name,
        profileurl: profileurl,
        type: type));
    notifyListeners();
    print(ss);
  }

  removedd() {
    ss.clear();
    notifyListeners();
  }
}
