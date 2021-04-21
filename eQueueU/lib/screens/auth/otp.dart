import 'dart:convert';

import 'package:eQueue/api/service/baseurl.dart';
import 'package:eQueue/constants/appcolor.dart';
import 'package:eQueue/screens/home_screen.dart';
import 'package:eQueue/screens/pages/home.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Otp extends StatefulWidget {
  String number;
  Otp({this.number});
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  var w = 0.8;
  int type = 0;
  String phone;
  String password;
  String error;
  final otpkey = GlobalKey<FormState>();
  BaseUrl baseUrl = BaseUrl();
  String lang;
  int sizz = 0;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  _getdevicetoken({String code}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _firebaseMessaging.getToken().then((token) {
      prefs.setString('devicetoken', token);
      print("Device Token: $token");
      login(code: code, devicetoken: token);
      prefs.setString('usertoken', token);
    });
  }

  Future login({String code, String devicetoken}) async {
    Uri registeruri = Uri.parse(baseUrl.login);
    var header = {
      'Content-Type': 'multipart/form-data',
    };
    var request = new http.MultipartRequest("POST", registeruri)
      ..headers.addAll(header);

    request.fields['number'] = widget.number;
    request.fields['code'] = code;
    request.fields['device_token'] = devicetoken;

    var res = await request.send();

    var response = await http.Response.fromStream(res);
    print(res.statusCode);
    if (res.statusCode == 200) {
      var n = json.decode(response.body);
      print(n['token']);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('token', n['token']);
      prefs.setString('language', 'English');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    } else {
      setState(() {
        error = 'Incorrect OTP';
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
            key: otpkey,
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
                    margin: EdgeInsets.only(top: height * 0.01),
                    height: height * 0.1,
                    width: width,
                    child: TextFormField(
                      maxLength: 6,
                      onChanged: (v) {
                        setState(() {
                          password = v;
                        });
                      },
                      validator: (name) {
                        if (name.isEmpty) {
                          return "Please enter OTP";
                        } else {
                          return null;
                        }
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.security,
                            color: Colors.white,
                          ),
                          errorStyle: TextStyle(fontWeight: FontWeight.bold),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Theme.of(context).errorColor,
                                width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                          ),
                          hintText: "OTP",
                          hintStyle: TextStyle(color: Colors.white)),
                    ),
                  ),
                  error == null
                      ? Container()
                      : Container(
                          child: Text(error),
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
                        if (otpkey.currentState.validate()) {
                          _getdevicetoken(code: password);
                        }

                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => MyHomePage(),
                        //     ));
                      },
                      child: type == 0
                          ? Text(
                              "Login",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 20),
                            )
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
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
