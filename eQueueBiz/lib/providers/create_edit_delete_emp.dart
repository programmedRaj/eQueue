import 'dart:io';

import 'package:equeuebiz/constants/api_constant.dart';
import 'package:equeuebiz/model/employee_model.dart';
import 'package:equeuebiz/services/app_toast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class EmployeeOperation extends ChangeNotifier {
  Future<bool> createEmployee(
      String token, File profilepic, EmployeeModel employeedets) async {
    var postUri = Uri.parse(Employee.createEditDeleteEmp);
    var header = {
      'Content-Type': 'multipart/form-data',
      'Authorization': token
    };

    var request = new http.MultipartRequest("POST", postUri)
      ..headers.addAll(header);

    if (profilepic != null) {
      request.files.add(http.MultipartFile(
          'profile_url',
          File(profilepic.path).readAsBytes().asStream(),
          File(profilepic.path).lengthSync(),
          filename: "${employeedets.email}_logo"));
    }

    request.fields["email"] = employeedets.email;
    request.fields["name"] = employeedets.name;
    request.fields["password"] = employeedets.password;
    request.fields["branch_id"] = employeedets.branchId.toString();
    request.fields["counter_number"] = employeedets.counterNumber.toString();
    request.fields["departments"] = employeedets.departments;
    request.fields["req"] = employeedets.req;
    request.fields["employee_id"] = employeedets.employeeId.toString();
    request.fields['services'] = employeedets.services;

    var resp = await request.send();
    if (resp.statusCode == 200) {
      print("Success");
      AppToast.showSucc("Employee details updated successfully");
      return true;
    } else {
      if (employeedets.req == "update") {
        AppToast.showErr("Employee details update failed");
      } else {
        AppToast.showErr("Employee created successfully");
      }
      return false;
    }
  }
}
