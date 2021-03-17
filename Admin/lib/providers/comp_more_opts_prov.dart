import 'package:equeue_admin/constants/api_constants.dart';
import 'package:equeue_admin/constants/appconstants.dart';
import 'package:equeue_admin/models/company_full_details.dart';
import 'package:equeue_admin/services/http_services.dart';
import 'package:equeue_admin/widgets/toast.dart';
import 'package:flutter/cupertino.dart';

class CompMoreOptsProv extends ChangeNotifier {
  bool isDisableLoading = false;
  bool isDisableErr = false;
  Future<bool> disableCompany(
      CompanyDets companyDets, CompEmailStatus compEmailStatus) async {
    var header = {
      'Content-Type': 'application/json',
      'Authorization': Token.statToken
    };
    var body = {
      "email": compEmailStatus.email,
      "company_id": companyDets.id,
      "disable": compEmailStatus.status == 1 ? 1 : 0
    };
    try {
      isDisableLoading = true;
      AppToast.showSucc("Disabling ${companyDets.name}");
      notifyListeners();
      var resp = await httpPostRequest(CompanyApi.disableComp, header, body);
      if (resp.statusCode == 200) {
        isDisableLoading = true;
        AppToast.showSucc("Disabled ${companyDets.name}");
        notifyListeners();
        return true;
      } else {
        isDisableLoading = false;
        isDisableErr = true;
        AppToast.showErr("Error disabling ${companyDets.name}");
        notifyListeners();
        return false;
      }
    } catch (e) {
      isDisableLoading = false;
      isDisableErr = true;
      AppToast.showErr("Error disabling ${companyDets.name}");

      notifyListeners();
      return false;
    }
  }
}
