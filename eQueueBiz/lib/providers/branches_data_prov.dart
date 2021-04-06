import 'dart:convert';
import 'package:equeuebiz/services/app_toast.dart';
import 'package:http/http.dart' as http;

import 'package:equeuebiz/constants/api_constant.dart';
import 'package:equeuebiz/model/branch_model.dart';
import 'package:equeuebiz/model/branch_resp_model.dart';
import 'package:equeuebiz/services/http_services.dart';
import 'package:flutter/cupertino.dart';

class BranchDataProv extends ChangeNotifier {
  bool isLoading = true;
  bool error = false;
  Map<String, int> branches = {};
  List<BranchRespModel> branchesWithDetail = [];

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

  getbranchesWithDetail(String jwtToken) async {
    var header = {
      'Content-Type': 'application/json',
      'Authorization': jwtToken
    };
    var resp = await httpGetRequest(BranchApi.getBranch, header);
    isLoading = true;
    error = false;
    branchesWithDetail = [];
    notifyListeners();
    if (resp.statusCode == 200) {
      var decodedResp = jsonDecode(resp.body);
      print(decodedResp);
      for (var item in decodedResp['branches']) {
        branchesWithDetail.add(BranchRespModel.fromJson(item));
      }
      isLoading = false;
      notifyListeners();
    } else {
      isLoading = false;
      error = true;
      notifyListeners();
    }
    /* try {
      
    } catch (e) {
      isLoading = false;
      error = true;
      notifyListeners();
    } */
  }

  Future<bool> execDeleteBranch(
      String jwtToken, int branchId, String branchName) async {
    AppToast.showSucc("Deleting branch $branchName");
    var header = {
      'Content-Type': 'application/json',
      'Authorization': jwtToken
    };
    var postUri = Uri.parse(BranchApi.createEditBranch);
    var request = new http.MultipartRequest("POST", postUri)
      ..headers.addAll(header);
    request.fields["branchid"] = branchId.toString();
    request.fields["req"] = "delete";

    var resp = await request.send();
    if (resp.statusCode == 200) {
      AppToast.showSucc("Deleted branch $branchName");
      return true;
    } else {
      AppToast.showErr("Error Deleting branch $branchName");
      return false;
    }
  }
}
