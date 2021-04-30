import 'dart:convert';

import 'package:equeuebiz/constants/appcolor.dart';
import 'package:equeuebiz/locale/app_localization.dart';
import 'package:equeuebiz/providers/auth_prov.dart';
import 'package:equeuebiz/providers/forgot_pass_prov.dart';
import 'package:equeuebiz/screens/homepage.dart';
import 'package:equeuebiz/services/app_toast.dart';
import 'package:equeuebiz/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ForgotPassPage extends StatefulWidget {
  @override
  _ForgotPassPageState createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  TextEditingController emailControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();
  TextEditingController otpControler = TextEditingController();
  String lang;

  @override
  void initState() {
    super.initState();
    getlang();
  }

  getlang() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      lang = prefs.getString('language');
    });
    if (lang == 'French') {
      AppLocalization.load(Locale('fr', 'FR'));
    } else if (lang == 'Spanish') {
      AppLocalization.load(Locale('es', 'ES'));
    } else if (lang == 'فارسی(Persian)') {
      AppLocalization.load(Locale('fa', 'FA'));
    } else if (lang == 'عربی(Arabic)') {
      AppLocalization.load(Locale('ar', 'AR'));
    } else if (lang == 'English') {
      AppLocalization.load(Locale('en', 'US'));
    } else {
      AppLocalization.load(Locale('en', 'US'));
    }
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
              appBar: whiteAppBar(context, "Forget Password"),
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
                                  AppToast.showSucc("verifying OTP");
                                  bool succ =
                                      await value.execChangeForgotPassSndOtp(
                                          emailControler.text,
                                          otpControler.text,
                                          passwordControler.text);
                                  if (succ) {
                                    AppToast.showSucc(
                                        "Password has been changed successfully");
                                    Navigator.pop(context);
                                  } else {
                                    AppToast.showErr("Wrong OTP");
                                  }
                                } else {
                                  bool isSuccess =
                                      await value.execForgotPassSndOtp(
                                          emailControler.text);
                                  if (isSuccess) {
                                    AppToast.showSucc(
                                        "OTP sent to your registerd email");
                                  } else {
                                    AppToast.showErr("Uh Oh ! Wrong Email");
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
                                      ? "Change Password"
                                      : "Send OTP",
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
        labelText: 'Enter email',
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
        labelText: 'Enter otp',
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
        labelText: 'Enter New Password',
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
