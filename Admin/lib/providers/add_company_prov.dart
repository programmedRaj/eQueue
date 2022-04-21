import 'dart:io';
import 'dart:typed_data';

import 'package:equeue_admin/constants/api_constants.dart';
import 'package:equeue_admin/constants/appconstants.dart';
import 'package:equeue_admin/enums/company_enum.dart';
import 'package:equeue_admin/models/add_company.dart';
import 'package:equeue_admin/providers/login_prov.dart';
import 'package:equeue_admin/widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AddCompanyProv extends ChangeNotifier {
  List<int>? comlogoint;
  Future<bool> execCreateComppany(Uint8List? companyLogo, AddCompany addCompany,
      bool edit, bool _isCheck) async {
    var postUri = Uri.parse(edit ? CompanyApi.edit : CompanyApi.create);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token')!;
    var header = {
      'Content-Type': 'multipart/form-data',
      'Authorization': token,
    };
    comlogoint = companyLogo != null ? List.from(companyLogo) : null;
    var request = new http.MultipartRequest("POST", postUri)
      ..headers.addAll(header);

    var ins = _isCheck ? 1 : 0;

    request.files.add(http.MultipartFile.fromBytes(
        'company_logo', comlogoint ?? [],
        filename: comlogoint == null
            ? ""
            : "${addCompany.name}_${DateTime.now().millisecondsSinceEpoch}_logo.png"));

    request.fields['acc_type'] = companyEnumToString(addCompany.accType)!;
    request.fields['email'] = addCompany.email!;
    request.fields['password'] = addCompany.password!;
    request.fields['insurance'] = ins == null ? '' : ins.toString();
    request.fields['name'] = addCompany.name!;
    request.fields['desc'] = addCompany.desc!;
    request.fields['bankname'] = addCompany.bankName!;
    request.fields['ifsc_code'] = addCompany.ifscCode!;
    request.fields['accountnumber'] = addCompany.accountNo!;
    request.fields['accountname'] = addCompany.accountName!;
    request.fields['oneliner'] = addCompany.onleLiner!;
    request.fields['company_id'] = addCompany.companyId.toString();

    var resp = await request.send();
    if (resp.statusCode == 200) {
      print("Success");
      return true;
    } else {
      if (edit) {
        AppToast.showErr("Company details editing failed");
      } else {
        AppToast.showErr("Company created successfully");
      }
      return false;
    }
  }
}
