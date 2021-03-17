import 'dart:convert';

import 'package:equeue_admin/constants/api_constants.dart';
import 'package:equeue_admin/constants/appconstants.dart';
import 'package:equeue_admin/models/company_full_details.dart';
import 'package:equeue_admin/services/http_services.dart';
import 'package:flutter/cupertino.dart';

class CompFullDetsProv extends ChangeNotifier {
  CompanyFullDetails companyFullDetails;
  bool isLoading = true;
  bool isError = false;

  getCompanyDets() async {
    try {
      var resp = await httpGetRequest(
          CompanyApi.compfullDets, {"Authorization": Token.statToken});
      if (resp.statusCode == 200) {
        var decodedResp = jsonDecode(resp.body);
        companyFullDetails = CompanyFullDetails.fromJson(decodedResp);
        isLoading = false;
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
