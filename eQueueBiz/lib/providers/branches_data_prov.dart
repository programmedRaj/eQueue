import 'dart:convert';

import 'package:equeuebiz/constants/api_constant.dart';
import 'package:equeuebiz/model/branch_model.dart';
import 'package:equeuebiz/services/http_services.dart';
import 'package:flutter/cupertino.dart';

class BranchDataProv extends ChangeNotifier {
  bool isLoading = true;
  bool error = false;
  Map<String, int> branches = {};

  getBranches(String jwtToken) async {
    var header = {
      'Content-Type': 'application/json',
      'Authorization': jwtToken
    };
    try {
      var resp = await httpGetRequest(BranchApi.getBranch, header);
      isLoading = true;
      error = false;
      branches = {};
      notifyListeners();
      if (resp.statusCode == 200) {
        var decodedResp = jsonDecode(resp.body);
        print(decodedResp);
        for (var item in decodedResp['branches']) {
          branches.putIfAbsent(item['bname'], () => item['id']);
        }
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        error = true;
        notifyListeners();
      }
    } catch (e) {
      isLoading = false;
      error = true;
      notifyListeners();
    }
  }
}
