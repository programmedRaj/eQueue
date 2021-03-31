import 'dart:ui';
import 'package:country_calling_code_picker/picker.dart';
import 'package:eQueue/components/color.dart';
import 'package:eQueue/screens/auth/register.dart';
import 'package:eQueue/screens/auth/verification.dart';
import 'package:eQueue/constants/appcolor.dart';
import 'package:eQueue/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final lkey = GlobalKey<FormState>();
  var w = 0.8;
  int type = 0;
  String phone;
  String password;
  String error;
  Country _selectedCountry;
  String lang;
  int sizz = 0;

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
                            height: sizz == 2 ? height * 0.12 : height * 0.06,
                            width: sizz == 1 ? width / 1.8 : width / 1.58,
                            margin: EdgeInsets.only(left: 15),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              validator: (name) {
                                if (name.isEmpty) {
                                  return 'Please enter phone number';
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
                                  hintText: "Phone",
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
                  Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    height: height * 0.08,
                    width: width,
                    child: TextFormField(
                      onChanged: (v) {
                        setState(() {
                          password = v;
                        });
                      },
                      validator: (name) {
                        if (name.isEmpty) {
                          return "Please enter password";
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyHomePage(),
                            ));
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
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: FlatButton(
                      child: Text(
                        "Create account",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
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
