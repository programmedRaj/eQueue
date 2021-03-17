import 'dart:io';
import 'dart:typed_data';

import 'package:equeue_admin/constants/api_constants.dart';
import 'package:equeue_admin/constants/appconstants.dart';
import 'package:equeue_admin/enums/company_enum.dart';
import 'package:equeue_admin/models/add_company.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AddCompanyProv extends ChangeNotifier {
  List<int> comlogoint;
  execCreateComppany(
      Uint8List companyLogo, AddCompany addCompany, bool edit) async {
    var postUri = Uri.parse(edit ? CompanyApi.edit : CompanyApi.create);
    var header = {
      'Content-Type': 'multipart/form-data',
      'Authorization': Token.statToken
    };
    comlogoint = companyLogo != null ? List.from(companyLogo) : null;
    var request = new http.MultipartRequest("POST", postUri)
      ..headers.addAll(header);

    request.files.add(http.MultipartFile.fromBytes(
        'company_logo', comlogoint ?? [],
        filename: "${addCompany.email}_logo"));

    request.fields['acc_type'] = companyEnumToString(addCompany.accType);
    request.fields['email'] = addCompany.email;
    request.fields['password'] = addCompany.password;

    request.fields['name'] = addCompany.name;
    request.fields['desc'] = addCompany.desc;
    request.fields['bankname'] = addCompany.bankName;
    request.fields['ifsc_code'] = addCompany.ifscCode;
    request.fields['accountnumber'] = addCompany.accountNo;
    request.fields['accountname'] = addCompany.accountName;
    request.fields['oneliner'] = addCompany.onleLiner;
    request.fields['company_id'] = addCompany.companyId.toString();

    var resp = await request.send();
    if (resp.statusCode == 200) {
      print("Success");
    }
  }
}
