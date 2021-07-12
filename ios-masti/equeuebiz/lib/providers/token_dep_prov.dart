import 'dart:convert';

import 'package:equeuebiz/constants/api_constant.dart';
import 'package:equeuebiz/services/http_services.dart';
import 'package:flutter/cupertino.dart';

class DeptTokenDataProv extends ChangeNotifier {
  bool isLoading = false;
  bool error = false;
  List<String> deptsList = [];

  Future<List<String>> getDeptstoken(String jwtToken, int branchId) async {
    var header = {
      'Content-Type': 'application/json',
      'Authorization': jwtToken
    };
    var postBody = {'branch_id': branchId};
    try {
      var resp = await httpPostRequest(DepartmentApi.getDept, header, postBody);
      isLoading = true;
      error = false;
      deptsList = [];
      notifyListeners();
      if (resp.statusCode == 200) {
        var decodedResp = jsonDecode(resp.body);
        print(decodedResp);
        // for (var item in decodedResp['services']) {
        //   deptsList.add(item);
        // }
        isLoading = false;
        notifyListeners();
        return deptsList;
      } else {
        isLoading = false;
        error = true;
        notifyListeners();
        return deptsList;
      }
    } catch (e) {
      isLoading = false;
      error = true;
      notifyListeners();
      return deptsList;
    }
  }
}
