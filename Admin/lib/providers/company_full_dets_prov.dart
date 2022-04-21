import 'dart:convert';

import 'package:equeue_admin/constants/api_constants.dart';
import 'package:equeue_admin/constants/appconstants.dart';
import 'package:equeue_admin/models/company_full_details.dart';
import 'package:equeue_admin/services/http_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompFullDetsProv extends ChangeNotifier {
  CompanyFullDetails? companyFullDetails;
  bool isLoading = true;
  bool isError = false;
  bool isEmpty = false;

  getCompanyDets() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token')!;
    try {
      var resp = await httpGetRequest(CompanyApi.compfullDets,
          {"Authorization": token, 'Content-Type': 'application/json'});
      print('res res ${resp.body}');
      if (resp.statusCode == 200) {
        var decodedResp = jsonDecode(resp.body);
        print('aa ${decodedResp['comp_emails_status']}');
        companyFullDetails = CompanyFullDetails.fromJson(decodedResp);
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
      print("Err in companyfulldetsprov : $e");
      isLoading = false;
      isError = true;
      notifyListeners();
    }
  }
}
