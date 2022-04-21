import 'dart:convert';
import 'dart:io';

import 'package:equeue_admin/constants/api_constants.dart';
import 'package:equeue_admin/constants/appconstants.dart';
import 'package:equeue_admin/models/branches_full_dets.dart';
import 'package:equeue_admin/models/company_full_details.dart';
import 'package:equeue_admin/models/emp_dets.dart';
import 'package:equeue_admin/models/user_dets.dart';
import 'package:equeue_admin/services/http_services.dart';
import 'package:equeue_admin/widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProv extends ChangeNotifier {
  List<UserDets>? userDetsList;
  bool isLoading = true;
  bool isError = false;
  bool isEmpty = false;

  getUsers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token')!;
    var header = {"Authorization": token, 'Content-Type': 'application/json'};
    try {
      var resp = await httpGetRequest(UsersApi.getUsers, header);
      if (resp.statusCode == 200) {
        var decodedResp = jsonDecode(resp.body);
        userDetsList = [];
        for (var i = 0; i < decodedResp['userdetails'].length; i++) {
          UserDets temp;
          temp = UserDets.fromJson(decodedResp['userdetails'][i]);

          userDetsList!.add(temp);
        }
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
      print("Err in branchfulldetsprov : $e");
      isLoading = false;
      isError = true;
      notifyListeners();
    }
  }

  Future<bool> deleteUser(UserDets userDets) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token')!;
    var header = {"Authorization": token, 'Content-Type': 'application/json'};
    try {
      AppToast.showSucc("Deleting user ${userDets.name}");
      var resp = await httpPostRequest(
          UsersApi.deleteUser, header, {"user_id": userDets.userId});
      if (resp.statusCode == 200) {
        AppToast.showErr("Successfully deleted user ${userDets.name}");

        return true;
      } else {
        AppToast.showErr("Error deleting user ${userDets.name}");

        notifyListeners();
        return false;
      }
    } catch (e) {
      print("Err in deleting user : $e");

      AppToast.showErr("Error deleting user ${userDets.name}");
      notifyListeners();
      return false;
    }
  }
}
