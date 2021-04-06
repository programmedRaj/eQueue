import 'dart:convert';

import 'package:equeuebiz/constants/api_constant.dart';
import 'package:equeuebiz/model/branch_model.dart';
import 'package:equeuebiz/services/http_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';

class DeptDataProv extends ChangeNotifier {
  bool isLoading = false;
  bool error = false;
  List<String> deptsList = [];

  getDepts(String jwtToken, int branchId) async {
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
        for (var item in decodedResp['services']) {
          deptsList.add(item);
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
