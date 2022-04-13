import 'package:equeuebiz/constants/appcolor.dart';
import 'package:equeuebiz/providers/auth_prov.dart';
import 'package:equeuebiz/providers/change_pass_prov.dart';
import 'package:equeuebiz/services/app_toast.dart';
import 'package:equeuebiz/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController _currentPassController = TextEditingController();
  TextEditingController _newPassController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var authProv = Provider.of<AuthProv>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          LocaleKeys.Change_Password,
          style: TextStyle(color: Colors.black),
        ).tr(),
      ),
      body: Container(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1200),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  _currentPassField(),
                  SizedBox(
                    height: 20,
                  ),
                  _newPassField(),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () async {
                      AppToast.showSucc(LocaleKeys.Changing_password.tr());
                      bool success = await ChangePassProv().execChangePass(
                          authProv.authinfo!.jwtToken!,
                          _currentPassController.text,
                          _newPassController.text);
                      if (success) {
                        AppToast.showSucc(
                            LocaleKeys.Password_changed_successfully.tr());
                      } else {
                        AppToast.showErr(LocaleKeys.Wrong_old_password.tr());
                      }
                    },
                    child: Container(
                      //width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                          color: AppColor.mainBlue,
                          borderRadius: BorderRadius.circular(4)),
                      alignment: Alignment.center,
                      child: Text(
                        LocaleKeys.Change_Password.tr(),
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }

  Widget _currentPassField() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(4)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      child: TextField(
        controller: _currentPassController,
        decoration: InputDecoration(
          hintText: LocaleKeys.Enter_current_Password.tr(),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget _newPassField() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(4)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      child: TextField(
        controller: _newPassController,
        decoration: InputDecoration(
          hintText: LocaleKeys.Enter_New_Password.tr(),
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}
