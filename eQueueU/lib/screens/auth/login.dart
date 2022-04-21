import 'dart:convert';
import 'dart:ui';
import 'package:country_calling_code_picker/picker.dart';
import 'package:eQueue/api/service/baseurl.dart';
import 'package:eQueue/components/color.dart';
import 'package:eQueue/screens/auth/otp.dart';
import 'package:eQueue/screens/auth/register.dart';
import 'package:eQueue/constants/appcolor.dart';
import 'package:eQueue/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:eQueue/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:http/http.dart' as http;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final lkey = GlobalKey<FormState>();
  var w = 0.8;
  int type = 0;
  late String phone;
  String? password;
  String? error;
  Country? _selectedCountry;
  String? lang;
  int sizz = 0;
  BaseUrl baseUrl = BaseUrl();

  @override
  void initState() {
    super.initState();
    initCountry();
  }

  void initCountry() async {
    final country = await getDefaultCountry(context);
    setState(() {
      _selectedCountry = country;
    });
  }

  void _onPressedShowBottomSheet() async {
    final country = await showCountryPickerSheet(
      context,
    );
    if (country != null) {
      setState(() {
        _selectedCountry = country;
      });
    }
  }

  Future login_otp(String phone, String code) async {
    Uri registeruri = Uri.parse(baseUrl.login_otp);

    var header = {
      'Content-Type': 'multipart/form-data',
    };
    var request = new http.MultipartRequest("POST", registeruri)
      ..headers.addAll(header);

    print(code + phone);

    if (phone.startsWith("0")) {
      phone = phone.substring(1);
    }
    request.fields['number'] = code + phone;

    var res = await request.send();
    var response = await http.Response.fromStream(res);
    print(res.statusCode);
    if (res.statusCode == 200) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Otp(
              number: code + phone,
            ),
          ));
    } else {
      setState(() {
        error = LocaleKeys.Userdoesnotexist.tr();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColor.mainBlue,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(30),
          child: Form(
            key: lkey,
            child: Center(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: height * 0.1, bottom: 30),
                    child: Image.asset(
                      'lib/assets/logo.png',
                      height: height * 0.2,
                      width: width * 0.3,
                    ),
                  ),
                  Container(
                    child: Row(
                      children: [
                        Container(
                          height: sizz == 2 ? height * 0.12 : height * 0.06,
                          width: width / 5.5,
                          decoration: BoxDecoration(
                              borderRadius: new BorderRadius.circular(10.0),
                              border:
                                  Border.all(color: Colors.white, width: 2.0)),
                          child: RaisedButton(
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(10.0),
                            ),
                            child: _selectedCountry == null
                                ? Text('+')
                                : Text(
                                    '${_selectedCountry?.callingCode ?? '+code'}',
                                    style: TextStyle(color: myColor[100]),
                                  ),
                            color: Theme.of(context).accentColor,
                            onPressed: _onPressedShowBottomSheet,
                          ),
                        ),
                        Flexible(
                          child: Container(
                            margin:
                                EdgeInsets.only(top: height * 0.01, left: 15),
                            height: height * 0.1,
                            width: width,
                            child: TextFormField(
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              validator: (name) {
                                if (name!.isEmpty) {
                                  return LocaleKeys.Pleaseenterphonenumber.tr();
                                } else
                                  return null;
                              },
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.security,
                                    color: Colors.white,
                                  ),
                                  errorStyle:
                                      TextStyle(fontWeight: FontWeight.bold),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Theme.of(context).errorColor,
                                        width: 2.0),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: Colors.white, width: 2.0),
                                  ),
                                  hintText: LocaleKeys.Phone.tr(),
                                  hintStyle: TextStyle(color: Colors.white)),
                              onChanged: (v) {
                                setState(() {
                                  phone = v;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  error == null
                      ? Container()
                      : Container(
                          child: Text(error!),
                        ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 1000),
                    margin: EdgeInsets.only(
                        left: 25, right: 25, top: height * 0.02, bottom: 2),
                    height: height * 0.08,
                    width: width * w,
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 4, color: Theme.of(context).primaryColor),
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(50)),
                    child: FlatButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        var code = _selectedCountry!.callingCode.substring(1);

                        if (lkey.currentState!.validate()) {
                          if (_selectedCountry != null) {
                            login_otp(phone, code);
                          }
                        }
                      },
                      child: type == 0
                          ? Text(
                              LocaleKeys.GetOtp,
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20),
                            ).tr()
                          : type == 1
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : Icon(
                                  Icons.done,
                                  color: Theme.of(context).primaryColor,
                                  size: 28,
                                ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: FlatButton(
                      child: Text(
                        LocaleKeys.Createaccount,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ).tr(),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Register(),
                            ));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
