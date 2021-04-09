import 'dart:io';

import 'package:equeuebiz/constants/api_constant.dart';
import 'package:equeuebiz/model/employee_model.dart';
import 'package:equeuebiz/services/app_toast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';

class EmployeeOperationProv {
  Future<bool> createEmployee(String token, File profilepic,
      EmployeeModel employeedets, String filename, String imagedesc) async {
    print('here');
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
          filename: "$filename"));
    } else {
      if (imagedesc != null) {
        request.files.add(http.MultipartFile.fromBytes(
            'profile_url', profilepic ?? [],
            filename: "$imagedesc"));
      }
      request.files
          .add(http.MultipartFile.fromBytes('profile_url', [], filename: ""));
    }
    print('------${employeedets.employeeId.toString()}');

    request.fields["email"] = employeedets.email;
    request.fields["name"] = employeedets.name;
    request.fields["password"] = employeedets.password;
    request.fields["branch_id"] = employeedets.branchId.toString();
    request.fields['number'] = employeedets.phoneNo;

    request.fields["counter_number"] = employeedets.counterNumber.toString();
    request.fields["departments"] = employeedets.departments;
    request.fields["req"] = employeedets.req;
    request.fields["employee_id"] = employeedets.employeeId.toString();
    request.fields['services'] = employeedets.services;
    request.fields['emp_status'] = employeedets.empStatus.toString();

    var resp = await request.send();
    if (resp.statusCode == 200) {
      print("Success");
      if (employeedets.req == "update") {
        AppToast.showSucc("Employee updated successfully");
      } else {
        AppToast.showSucc("Employee created successfully");
      }

      return true;
    } else {
      if (employeedets.req == "update") {
        AppToast.showErr("Employee update failed");
      } else {
        AppToast.showErr("Employee creation failed");
      }
      return false;
    }
  }

  Future<bool> execDeleteEmployee(
    String jwtToken,
    int employeeId,
    String filename,
  ) async {
    AppToast.showSucc("Deleting Employee ");
    var header = {
      'Content-Type': 'application/json',
      'Authorization': jwtToken
    };
    var postUri = Uri.parse(Employee.createEditDeleteEmp);
    var request = new http.MultipartRequest("POST", postUri)
      ..headers.addAll(header);

    request.files.add(
        http.MultipartFile.fromBytes('profile_url', [], filename: "$filename"));

    request.fields["branch_id"] = '';
    request.fields["number"] = '';
    request.fields["name"] = '';
    request.fields["email"] = '';
    request.fields["password"] = '';
    request.fields["req"] = "delete";
    request.fields["employee_id"] = employeeId.toString();

    var resp = await request.send();
    if (resp.statusCode == 200) {
      AppToast.showSucc("Deleted Employee ");
      return true;
    } else {
      AppToast.showErr("Error Deleting Employee");
      return false;
    }
  }
}
