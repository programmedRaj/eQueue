import 'package:equeue_admin/constants/api_constants.dart';
import 'package:equeue_admin/constants/appconstants.dart';
import 'package:equeue_admin/models/company_full_details.dart';
import 'package:equeue_admin/services/http_services.dart';
import 'package:equeue_admin/widgets/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompMoreOptsProv extends ChangeNotifier {
  bool isDisableLoading = false;
  bool isDisableErr = false;
  Future<bool> disableCompany(CompanyDets companyDets,
      CompEmailStatus compEmailStatus, jwtToken) async {
    Map<String, String> header = {
      'Content-Type': 'application/json',
      'Authorization': jwtToken
    };
    var body = {
      "email": compEmailStatus.email,
      "company_id": companyDets.id,
      "disable": compEmailStatus.status == 1 ? 1 : 0
    };
    try {
      isDisableLoading = true;
      AppToast.showSucc(
          " ${compEmailStatus.status == 1 ? 'Disabling' : 'Enabling'} ${companyDets.name}");
      notifyListeners();
      var resp = await httpPostRequest(CompanyApi.disableComp, header, body);
      if (resp.statusCode == 200) {
        isDisableLoading = true;
        AppToast.showSucc(
            "${compEmailStatus.status == 1 ? 'Disabled' : 'Enabled'} ${companyDets.name}");
        notifyListeners();
        return true;
      } else {
        isDisableLoading = false;
        isDisableErr = true;
        AppToast.showErr(
            "Error ${compEmailStatus.status == 1 ? 'Disabling' : 'Enabling'} ${companyDets.name}");
        notifyListeners();
        return false;
      }
    } catch (e) {
      isDisableLoading = false;
      isDisableErr = true;
      AppToast.showErr(
          "Error ${compEmailStatus.status == 1 ? 'Disabling' : 'Enabling'} ${companyDets.name}");

      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteCompany(
      CompanyDets companyDets, CompEmailStatus compEmailStatus) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token')!;
    var header = {'Content-Type': 'application/json', 'Authorization': token};
    var body = {
      "company_id": companyDets.id,
    };
    try {
      isDisableLoading = true;
      AppToast.showSucc("Deleting ${companyDets.name}");
      notifyListeners();
      var resp = await httpPostRequest(CompanyApi.deleteComp, header, body);
      if (resp.statusCode == 200) {
        isDisableLoading = true;
        AppToast.showSucc("Deleted ${companyDets.name}");
        notifyListeners();
        return true;
      } else {
        isDisableLoading = false;
        isDisableErr = true;
        AppToast.showErr("Error deleting ${companyDets.name}");
        notifyListeners();
        return false;
      }
    } catch (e) {
      isDisableLoading = false;
      isDisableErr = true;
      AppToast.showErr("Error deleting ${companyDets.name}");

      notifyListeners();
      return false;
    }
  }
}
