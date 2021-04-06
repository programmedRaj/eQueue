import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:equeuebiz/services/app_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:equeuebiz/constants/api_constant.dart';
import 'package:equeuebiz/model/branch_model.dart';

class CreateEditBanchProv extends ChangeNotifier {
  List<int> comlogoint;
  Future<bool> execCreateComppany(BranchModel branch, String token,
      {Uint8List companyLogo, File companyLogoMob}) async {
    var postUri = Uri.parse(BranchApi.createEditBranch);
    var header = {
      'Content-Type': 'multipart/form-data',
      'Authorization': token
    };
    comlogoint = companyLogo != null ? List.from(companyLogo) : null;
    var request = new http.MultipartRequest("POST", postUri)
      ..headers.addAll(header);

    if (companyLogoMob != null) {
      request.files.add(http.MultipartFile(
          'company_logo',
          File(companyLogoMob.path).readAsBytes().asStream(),
          File(companyLogoMob.path).lengthSync(),
          filename: "${branch.branchName}_logo"));
    } else {
      request.files.add(http.MultipartFile.fromBytes(
          'company_logo', comlogoint ?? [],
          filename: "${branch.branchName}_logo"));
    }

    request.fields["bname"] = branch.branchName;
    request.fields["pnum"] = branch.phoneNo;
    request.fields["addr1"] = branch.addr1;
    request.fields["addr2"] = branch.addr2;
    request.fields["city"] = branch.city;
    request.fields["postalcode"] = branch.postalCode;
    request.fields["geolocation"] = branch.geoLoaction;
    request.fields["province"] = branch.province;
    request.fields["w_hrs"] = jsonEncode(branch.workingHrs);
    request.fields["services"] = jsonEncode(branch.services);
    request.fields["timezone"] = "jnf";
    request.fields["notify"] = "lkrrf";
    request.fields["booking_perday"] = jsonEncode(branch.bookingPerday);
    request.fields["booking_perhrs"] = jsonEncode(branch.bookingPerDayhrs);
    request.fields["req"] = branch.reqType;
    request.fields["threshold"] = branch.threshold;
    request.fields["department"] = jsonEncode(branch.department);
    request.fields["branchid"] = branch.branchId;
    request.fields["counter"] = branch.counter;

    var resp = await request.send();
    if (resp.statusCode == 200) {
      print("Success");
      if (branch.reqType == "update") {
        AppToast.showErr("Branch updated successfully");
      } else {
        AppToast.showSucc("Branch created successfully");
      }

      return true;
    } else {
      if (branch.reqType == "update") {
        AppToast.showErr("Branch update failed");
      } else {
        AppToast.showErr("Branch creation failed");
      }
      return false;
    }
  }
}
