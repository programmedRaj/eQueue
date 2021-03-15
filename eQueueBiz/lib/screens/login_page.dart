import 'dart:convert';

import 'package:equeuebiz/constants/appcolor.dart';
import 'package:equeuebiz/locale/app_localization.dart';
import 'package:equeuebiz/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userNameControler = TextEditingController();
  TextEditingController passwordControler = TextEditingController();
  String lang;

  @override
  void initState() {
    super.initState();
    getlang();
  }

  executeLogin(String email, String password) async {
    try {
      var url = Uri.parse('http://127.0.0.1:5000/adminsign_in');
      http
          .post(url,
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode({'email': email, 'password': password}))
          .then((value) {
        print(jsonDecode(value.body));
      });
    } catch (e) {
      print(e);
    }
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
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
                    Flexible(child: _userNameTextField()),
                    Flexible(
                      child: SizedBox(
                        height: 20,
                      ),
                    ),
                    Flexible(child: _passwordTextField()),
                    Flexible(
                        child: SizedBox(
                      height: 20,
                    )),
                    Flexible(
                      child: InkWell(
                        onTap: () {
                          executeLogin("admin@equeue.app", "password");
                          /* Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              )); */
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          decoration: BoxDecoration(
                              color: AppColor.darkBlue,
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(
                            AppLocalization.of(context).login,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      AppLocalization.of(context).forgetpassword,
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _userNameTextField() {
    return TextFormField(
      controller: userNameControler,
      keyboardType: TextInputType.number,
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
        labelText: 'Enter username',
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

  Widget _passwordTextField() {
    return TextFormField(
      controller: passwordControler,
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
        labelText: 'Enter password',
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
