import 'package:equeuebiz/constants/appcolor.dart';
import 'package:equeuebiz/providers/forgot_pass_prov.dart';
import 'package:equeuebiz/services/app_toast.dart';
import 'package:equeuebiz/translations/locale_keys.g.dart';
import 'package:equeuebiz/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class ForgotPassPage extends StatefulWidget {
  @override
  _ForgotPassPageState createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  TextEditingController emailControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();
  TextEditingController otpControler = TextEditingController();
  String? lang;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ForgotPassProv>(
      create: (_) => ForgotPassProv(),
      child: Consumer<ForgotPassProv>(
        builder: (context, value, child) {
          return GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              appBar: whiteAppBar(context, LocaleKeys.Forget_Password.tr()) as PreferredSizeWidget?,
              body: Container(
                alignment: Alignment.center,
                color: Colors.white,
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 400),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: AppColor.mainBlue,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 5)
                          ]),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          value.vanishEmail
                              ? SizedBox()
                              : Flexible(child: _emailTextField()),
                          value.vanishEmail
                              ? SizedBox()
                              : Flexible(
                                  child: SizedBox(
                                    height: 20,
                                  ),
                                ),
                          value.showBottom2fields
                              ? Flexible(child: _otpTextField())
                              : SizedBox(),
                          value.showBottom2fields
                              ? Flexible(
                                  child: SizedBox(
                                  height: 20,
                                ))
                              : SizedBox(),
                          value.showBottom2fields
                              ? Flexible(child: _newPassTextField())
                              : SizedBox(),
                          Flexible(
                              child: SizedBox(
                            height: 20,
                          )),
                          Flexible(
                            child: InkWell(
                              onTap: () async {
                                if (value.vanishEmail) {
                                  AppToast.showSucc(
                                      LocaleKeys.verifying_OTP.tr());
                                  bool succ =
                                      await value.execChangeForgotPassSndOtp(
                                          emailControler.text,
                                          otpControler.text,
                                          passwordControler.text);
                                  if (succ) {
                                    AppToast.showSucc(LocaleKeys
                                        .Password_changed_successfully.tr());
                                    Navigator.pop(context);
                                  } else {
                                    AppToast.showErr(LocaleKeys.Wrong_OTP.tr());
                                  }
                                } else {
                                  bool isSuccess =
                                      await value.execForgotPassSndOtp(
                                          emailControler.text);
                                  if (isSuccess) {
                                    AppToast.showSucc(LocaleKeys
                                        .OTP_sent_to_your_registerd_email.tr());
                                  } else {
                                    AppToast.showErr(
                                        LocaleKeys.Uh_Oh_Wrong_Email.tr());
                                  }
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                                decoration: BoxDecoration(
                                    color: AppColor.darkBlue,
                                    borderRadius: BorderRadius.circular(5)),
                                child: Text(
                                  value.vanishEmail
                                      ? LocaleKeys.Change_Password.tr()
                                      : LocaleKeys.Send_OTP.tr(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _emailTextField() {
    return TextFormField(
      controller: emailControler,
      style: TextStyle(fontSize: 20.5),
      decoration: InputDecoration(
        //focusColor: Colors.green,
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        prefixIcon: Icon(
          Icons.person,
          color: Colors.white,
          size: 25.5,
        ),
        contentPadding: EdgeInsets.only(left: 0, top: 15, bottom: 0),
        labelText: LocaleKeys.Enter_email.tr(),
        labelStyle: TextStyle(fontSize: 16, color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            style: BorderStyle.none,
            color: Colors.green,
          ),
        ),
      ),
    );
  }

  Widget _otpTextField() {
    return TextFormField(
      controller: otpControler,
      keyboardType: TextInputType.number,
      style: TextStyle(fontSize: 20.5),
      decoration: InputDecoration(
        //focusColor: Colors.green,
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),

        prefixIcon: Icon(
          Icons.star,
          color: Colors.white,
          size: 25.5,
        ),
        contentPadding: EdgeInsets.only(left: 0, top: 15, bottom: 0),
        labelText: LocaleKeys.Enter_otp.tr(),
        labelStyle: TextStyle(fontSize: 16, color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            style: BorderStyle.none,
            color: Colors.green,
          ),
        ),
      ),
    );
  }

  Widget _newPassTextField() {
    return TextFormField(
      controller: passwordControler,
      style: TextStyle(fontSize: 20.5),
      decoration: InputDecoration(
        //focusColor: Colors.green,
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),

        prefixIcon: Icon(
          Icons.star,
          color: Colors.white,
          size: 25.5,
        ),
        contentPadding: EdgeInsets.only(left: 0, top: 15, bottom: 0),
        labelText: LocaleKeys.Enter_New_Password.tr(),
        labelStyle: TextStyle(fontSize: 16, color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            style: BorderStyle.none,
            color: Colors.green,
          ),
        ),
      ),
    );
  }
}
