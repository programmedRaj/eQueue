import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:equeuebiz/providers/emp_data_provider.dart';
import 'package:equeuebiz/services/app_toast.dart';
import 'package:http/http.dart' as http;

import 'package:equeuebiz/constants/api_constant.dart';
import 'package:equeuebiz/model/branch_model.dart';
import 'package:equeuebiz/model/branch_resp_model.dart';
import 'package:equeuebiz/services/http_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class BranchDataProv extends ChangeNotifier {
  bool isLoading = true;
  bool error = false;
  Map<int, String> branches = {};
  bool noBranches = false;
  List<BranchRespModel> branchesWithDetail = [];
  List branchWithImages = [];

  Future<bool> getBranches(BuildContext context, String jwtToken) async {
    var header = {
      'Content-Type': 'application/json',
      'Authorization': jwtToken
    };
    try {
      var resp = await httpGetRequest(BranchApi.getBranch, header);
      isLoading = true;
      error = false;
      noBranches = false;
      branches = {};
      notifyListeners();

      if (resp.statusCode == 200) {
        var decodedResp = jsonDecode(resp.body);
        print(decodedResp['branches'][0]['profile_photo_url']);

        for (var item in decodedResp['branches']) {
          branches.putIfAbsent(item['id'], () => item['bname']);
        }
        var _temp = branches.keys.toList();
        isLoading = false;
        Provider.of<EmpDataProv>(context, listen: false)
            .getEmployeesWithDetailAcctoBranch(jwtToken, _temp[0]);
        notifyListeners();
        return true;
      } else if (resp.statusCode == 403) {
        noBranches = true;
        isLoading = false;
        error = true;
        notifyListeners();
        return false;
      } else {
        isLoading = false;
        error = true;
        notifyListeners();
        return false;
      }
    } catch (e) {
      isLoading = false;
      error = true;
      notifyListeners();
      return false;
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
    branchWithImages = [];
    notifyListeners();
    if (resp.statusCode == 200) {
      var decodedResp = jsonDecode(resp.body);

      for (int i = 0; i < decodedResp['branches'].length; i++) {
        branchWithImages.add(decodedResp['branches'][i]['profile_photo_url']);
      }
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

  Future<bool> execDeleteBranch(String jwtToken, int branchId,
      String branchName, BranchRespModel branchDets) async {
    AppToast.showSucc("Deleting branch $branchName");
    var header = {
      'Content-Type': 'application/json',
      'Authorization': jwtToken
    };
    var postUri = Uri.parse(BranchApi.createEditBranch);
    var request = new http.MultipartRequest("POST", postUri)
      ..headers.addAll(header);

    request.files.add(http.MultipartFile.fromBytes('profile_photo_url', [],
        filename: "${branchId}_logo"));
    request.fields["bname"] = '';
    request.fields["pnum"] = '';
    request.fields["addr1"] = '';
    request.fields["addr2"] = '';
    request.fields["city"] = '';
    request.fields["postalcode"] = '';
    request.fields["geolocation"] = '';
    request.fields["province"] = '';
    request.fields["w_hrs"] = jsonEncode({});
    request.fields["req"] = "delete";
    request.fields["branchid"] = branchId.toString();

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
