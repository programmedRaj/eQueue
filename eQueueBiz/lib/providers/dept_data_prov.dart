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

  Future<List<String>> getDepts(String jwtToken, int branchId) async {
    print(jwtToken);
    var header = {
      'Content-Type': 'application/json',
      'Authorization': jwtToken
    };
    print(branchId);
    var postBody = {'branch_id': branchId};
    try {
      var resp = await httpPostRequest(DepartmentApi.getDept, header, postBody);
      isLoading = true;
      error = false;
      deptsList = [];
      notifyListeners();
      var decodedResp = jsonDecode(resp.body);
      print(decodedResp);
      if (resp.statusCode == 200) {
        if (decodedResp['services'] == null) {
          for (var item in decodedResp['departments']) {
            deptsList.add(item);
            print('dep dep ${decodedResp['departments']}');
          }
        }
        if (decodedResp['services'] != null) {
          for (var item in decodedResp['services']) {
            deptsList.add(item);
          }
        }
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
      print(e);
      isLoading = false;
      error = true;
      notifyListeners();
      return deptsList;
    }
  }
}
