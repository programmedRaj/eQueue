import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:equeuebiz/constants/api_constant.dart';
import 'package:equeuebiz/model/all_tokens.dart';
import 'package:equeuebiz/model/bookinh_model.dart';
import 'package:equeuebiz/model/branch_model.dart';
import 'package:equeuebiz/services/app_toast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AllMToken with ChangeNotifier {
  String totalM;
  String get totalMm => totalM;
  getTokeMndets(String bid, String bname, String token) async {
    var map = new Map<String, dynamic>();
    map['branch_id'] = bid.toString();
    map['branch_name'] = bname.toString();

    var response = await retry(
      () => http
          .post(Uri.parse(MutliTokenApi.allmulti),
              headers: {"Authorization": token}, body: map)
          .timeout(Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    var k = response.body;
    var n = json.decode(k);
    print(n);

    totalM = n['tokens'];

    //   if (response.statusCode == 200) {
    //     removetoken();
    //     if (n['tokens'] != null) {
    //       for (int i = 0; i < n['tokens'].length; i++) {
    //         addtoken(
    //           branchid: n['tokens'][i]['branch_id'].toString(),
    //           counterno: n['tokens'][i]['counter_number'].toString(),
    //           createtime: n['tokens'][i]['create_time'],
    //           department: n['tokens'][i]['department'],
    //           devicetoken: n['tokens'][i]['device_token'],
    //           employeeid: n['tokens'][i]['employee_id'].toString(),
    //           id: n['tokens'][i]['id'].toString(),
    //           insurance: n['tokens'][i]['insurance'],
    //           slots: n['tokens'][i]['slots'],
    //           status: n['tokens'][i]['status'],
    //           userid: n['tokens'][i]['user_id'].toString(),
    //         );
    //       }
    //     } else {
    //       AppToast.showErr('No Token');
    //     }
    //   } else {
    //     AppToast.showErr('No Token');
    //   }
    // }

    // List<TokenAll> tok = [];

    // List<TokenAll> get toks => tok;
    // addtoken({
    //   String branchid,
    //   String counterno,
    //   String createtime,
    //   String department,
    //   String devicetoken,
    //   String employeeid,
    //   String id,
    //   String insurance,
    //   String slots,
    //   String status,
    //   String userid,
    // }) {
    //   toks.add(TokenAll(
    //     branchid: branchid,
    //     counterno: counterno,
    //     createtime: createtime,
    //     department: department,
    //     devicetoken: devicetoken,
    //     employeeid: employeeid,
    //     id: id,
    //     insurance: insurance,
    //     slots: slots,
    //     status: status,
    //     userid: userid,
    //   ));
    //   notifyListeners();
    // }

    // removetoken() {
    //   toks.clear();
    //   notifyListeners();
  }
}
