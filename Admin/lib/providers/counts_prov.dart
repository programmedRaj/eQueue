import 'dart:convert';

import 'package:equeue_admin/constants/api_constants.dart';
import 'package:equeue_admin/constants/appconstants.dart';
import 'package:equeue_admin/models/branches_full_dets.dart';
import 'package:equeue_admin/models/company_full_details.dart';
import 'package:equeue_admin/models/counts_model.dart';
import 'package:equeue_admin/models/emp_dets.dart';
import 'package:equeue_admin/services/http_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CountsProv extends ChangeNotifier {
  CountsModel conutData;
  bool isLoading = true;
  bool isError = false;
  bool isEmpty = false;

  getCounts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    var header = {"Authorization": token, 'Content-Type': 'application/json'};
    try {
      var resp = await httpGetRequest(OtherApi.getCounts, header);
      if (resp.statusCode == 200) {
        var decodeResp = jsonDecode(resp.body);
        conutData = CountsModel.fromJson(decodeResp);
        isLoading = false;
        notifyListeners();
      } else if (resp.statusCode == 403) {
        isLoading = false;
        isError = true;
        isEmpty = true;
        notifyListeners();
      } else {
        isLoading = false;
        isError = true;
        notifyListeners();
      }
    } catch (e) {
      print("Err in branchfulldetsprov : $e");
      isLoading = false;
      isError = true;
      notifyListeners();
    }
  }
}
