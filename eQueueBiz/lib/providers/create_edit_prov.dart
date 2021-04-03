import 'dart:typed_data';
import 'package:equeuebiz/services/app_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:equeuebiz/constants/api_constant.dart';
import 'package:equeuebiz/model/company_model.dart';

class CreateEditBanchProv extends ChangeNotifier {
  List<int> comlogoint;
  Future<bool> execCreateComppany(
      Uint8List companyLogo, BranchModel branch, String token) async {
    var postUri = Uri.parse(Branch.createEditBranch);
    var header = {
      'Content-Type': 'multipart/form-data',
      'Authorization': token
    };
    comlogoint = companyLogo != null ? List.from(companyLogo) : null;
    var request = new http.MultipartRequest("POST", postUri)
      ..headers.addAll(header);

    request.files.add(http.MultipartFile.fromBytes(
        'company_logo', comlogoint ?? [],
        filename: "${branch.branchName}_logo"));

    request.fields["bname"] = branch.branchName;
    request.fields["pnum"] = branch.phoneNo;
    request.fields["addr1"] = branch.addr1;
    request.fields["addr2"] = branch.addr2;
    request.fields["city"] = branch.city;
    request.fields["postalcode"] = branch.postalCode;
    request.fields["geolocation"] = branch.geoLoaction;
    request.fields["province"] = branch.province;
    request.fields["w_hrs"] = "";
    request.fields["services"] = "";
    request.fields["timezone"] = "";
    request.fields["notify"] = "";
    request.fields["booking_perday"] = "";
    request.fields["booking_perhrs"] = "";
    request.fields["req"] = branch.reqType;
    request.fields["threshold"] = branch.threshold;
    request.fields["department"] = branch.department.toString();
    request.fields["branchid"] = "";

    var resp = await request.send();
    if (resp.statusCode == 200) {
      print("Success");
      return true;
    } else {
      if (branch.reqType == "update") {
        AppToast.showErr("Branch details editing failed");
      } else {
        AppToast.showErr("Branch created successfully");
      }
      return false;
    }
  }
}
