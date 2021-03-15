import 'dart:io';
import 'dart:typed_data';

import 'package:equeue_admin/constants/api_constants.dart';
import 'package:equeue_admin/constants/appconstants.dart';
import 'package:equeue_admin/models/add_company.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AddCompanyProv extends ChangeNotifier {
  List<int> comlogoint;
  execCreateComppany(Uint8List companyLogo, AddCompany addCompany) async {
    var postUri = Uri.parse(CompanyApi.create);
    var header = {
      'Content-Type': 'multipart/form-data',
      'Authorization': Token.statToken
    };
    comlogoint = List.from(companyLogo);
    var request = new http.MultipartRequest("POST", postUri)
      ..headers.addAll(header);
    request.files.add(http.MultipartFile.fromBytes('company_logo', comlogoint,
        filename: "company_ka_logo"));
    request.fields['acc_type'] = "multitoken";
    request.fields['email'] = "test@gmail.com";
    request.fields['password'] = "test";

    request.fields['name'] = addCompany.name;
    request.fields['desc'] = addCompany.desc;
    request.fields['bankname'] = addCompany.bankName;
    request.fields['ifsc_code'] = addCompany.ifscCode;
    request.fields['accountnumber'] = addCompany.accountNo;
    request.fields['accountname'] = addCompany.accountName;
    request.fields['oneliner'] = addCompany.onleLiner;

    var resp = await request.send();
    if (resp.statusCode == 200) {
      print("Success");
    }
  }
}
