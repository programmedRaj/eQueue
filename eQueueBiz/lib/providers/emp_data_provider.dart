import 'dart:convert';
import 'package:equeuebiz/model/employee_model.dart';
import 'package:equeuebiz/services/app_toast.dart';
import 'package:http/http.dart' as http;

import 'package:equeuebiz/constants/api_constant.dart';
import 'package:equeuebiz/services/http_services.dart';
import 'package:flutter/cupertino.dart';

class EmpDataProv extends ChangeNotifier {
  bool isLoading = true;
  bool error = false;
  Map<String, int> branches = {};
  List<EmployeeModel> employeesWithDetail = [];
  List employeesWithImage = [];
  List employeeratings = [];

  getEmployeesWithDetailAcctoBranch(String jwtToken, int branchId) async {
    var header = {
      'Content-Type': 'application/json',
      'Authorization': jwtToken
    };
    var body = {"branch_id": branchId};
    var resp = await httpPostRequest(Employee.getEmpolyee, header, body);
    isLoading = true;
    error = false;
    employeesWithDetail = [];
    notifyListeners();
    if (resp.statusCode == 200) {
      var decodedResp = jsonDecode(resp.body);
      print(decodedResp);
      employeesWithImage.clear();
      employeeratings.clear();
      for (int i = 0; i < decodedResp['employee_details'].length; i++) {
        print('aaaaa bbbbb ${decodedResp['employee_details'][i]['ratings']}');
        employeesWithImage
            .add(decodedResp['employee_details'][i]['profile_url']);
        employeeratings.add(decodedResp['employee_details'][i]['ratings']);
      }
      int i = 0;
      for (var item in decodedResp['employee_details']) {
        EmployeeModel employee = EmployeeModel.fromJson(item);
        print(employee.branchId);
        employee.empStatus = decodedResp['empoyee_statuses'][i];
        employeesWithDetail.add(employee);
        i++;
      }
      isLoading = false;
      notifyListeners();
    } else {
      isLoading = false;
      error = true;
      notifyListeners();
    }
    /* try {
      
    } catch (e) {
      isLoading = false;
      error = true;
      notifyListeners();
    } */
  }

  Future<bool> execDeleteBranch(
      String jwtToken, int branchId, String branchName) async {
    AppToast.showSucc("Deleting branch $branchName");
    var header = {
      'Content-Type': 'application/json',
      'Authorization': jwtToken
    };
    var postUri = Uri.parse(BranchApi.createEditBranch);
    var request = new http.MultipartRequest("POST", postUri)
      ..headers.addAll(header);

    request.fields["req"] = "delete";
    request.fields["branchid"] = branchId.toString();

    var resp = await request.send();
    if (resp.statusCode == 200) {
      AppToast.showSucc("Deleted branch $branchName");
      return true;
    } else {
      AppToast.showErr("Error Deleting branch $branchName");
      return false;
    }
  }
}
