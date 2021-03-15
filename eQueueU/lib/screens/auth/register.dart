import 'dart:ui';

import 'package:eQueue/constants/appcolor.dart';
import 'package:eQueue/screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final rkey = GlobalKey<FormState>();
  var w = 0.8;
  int type = 0;
  String email;
  String password;
  String name;
  String nickname;
  String phone;
  String number;
  String error;
  String lang;
  int sizz = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    if (width <= 320.0) {
      setState(() {
        sizz = 1;
      });
    } else if (height <= 850) {
      setState(() {
        sizz = 2;
      });
    }

    /* Future addusertodb(String uid, String nickname, String name, String phone,
        String email, String password) async {
      await store.collection('users').doc(uid).set({
        'userid': uid,
        'nickname': nickname,
        'name': name,
        'phone': phone,
        'email': email,
        'type': 'user',
        'image': ''
      });
    }

    registerwithemailpassword(String nickname, String name, String phone,
        String email, String password) async {
      try {
        final result = await auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .catchError((e) {
          setState(() {
            error = e.toString();
          });
          print(e);
        });
        final User user = result.user;
        addusertodb(user.uid, nickname, name, phone, email, password);
        print(user);
      } on PlatformException catch (e) {
        setState(() {
          w = 0.8;
          type = 0;
          error = e.message.toString();
        });
        print(e.message);
      } catch (e) {
        setState(() {
          w = 0.8;
          type = 0;
          error = e.message.toString();
        });

        print(error);
      }
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
    } */

    @override
    // ignore: unused_element
    void initState() {
      // initCountry();
      super.initState();
    }

    return Scaffold(
      backgroundColor: AppColor.mainBlue,
      body: SafeArea(
        child: SingleChildScrollView(
            child: Container(
          margin: EdgeInsets.all(30),
          child: Form(
              key: rkey,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 50, bottom: 30),
                    child: Image.asset(
                      'lib/assets/logo.png',
                      height: height * 0.2,
                      width: width * 0.3,
                    ),
                  ),
                  Container(
                    height: sizz == 2 ? height * 0.12 : height * 0.08,
                    width: width,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      /* validator: (name) {
                        if (name.isEmpty)
                          return AppLocalization.of(context).enternickname;
                        else
                          return null;
                      }, */
                      decoration: InputDecoration(
                        hintText: "Name",
                        hintStyle: TextStyle(
                            color: Colors
                                .white), //AppLocalization.of(context).nickname,
                        prefixIcon: Icon(
                          Icons.people,
                          color: Colors.white,
                        ),
                        errorStyle: TextStyle(fontWeight: FontWeight.bold),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Theme.of(context).errorColor, width: 2.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Theme.of(context).errorColor, width: 2.0),
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
                      ),
                      onChanged: (v) {
                        setState(() {
                          nickname = v;
                        });
                      },
                    ),
                  ),
                  Container(
                    height: sizz == 2 ? height * 0.12 : height * 0.08,
                    width: width,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (name) {
                        if (name.isEmpty)
                          return "please enter name";
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Referral Code",
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                        errorStyle: TextStyle(fontWeight: FontWeight.bold),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Theme.of(context).errorColor, width: 2.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Theme.of(context).errorColor, width: 2.0),
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
                      ),
                      onChanged: (v) {
                        setState(() {
                          name = v;
                        });
                      },
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: sizz == 2 ? height * 0.09 : height * 0.06,
                        width: width / 5.5,
                        decoration: BoxDecoration(
                            color: AppColor.mainBlue,
                            borderRadius: new BorderRadius.circular(10.0),
                            border:
                                Border.all(color: Colors.white, width: 2.0)),
                        alignment: Alignment.center,
                        child: Text(
                          "+91",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        height: sizz == 2 ? height * 0.12 : height * 0.08,
                        width: sizz == 1 ? width / 1.8 : width / 1.7,
                        margin: EdgeInsets.only(left: 15),
                        child: TextFormField(
                          maxLength: 10,
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (name) {
                            if (name.length < 10) {
                              return 'Please enter correct phone number';
                            } else if (name.isEmpty) {
                              return 'Please enter phone number';
                            } else
                              return null;
                          },
                          decoration: InputDecoration(
                            counterText: "",
                            hintText: "Mobile number",
                            hintStyle: TextStyle(color: Colors.white),
                            prefixIcon: Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                            errorStyle: TextStyle(fontWeight: FontWeight.bold),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Theme.of(context).errorColor,
                                  width: 2.0),
                            ),
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
                          ),
                          onChanged: (v) {
                            setState(() {
                              phone = v;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: height * 0.01),
                    height: sizz == 2 ? height * 0.12 : height * 0.08,
                    width: width,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (name) {
                        if (name.isEmpty)
                          return "Please enter email";
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(
                          Icons.email,
                          color: Colors.white,
                        ),
                        errorStyle: TextStyle(fontWeight: FontWeight.bold),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Theme.of(context).errorColor, width: 2.0),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(
                              color: Theme.of(context).errorColor, width: 2.0),
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
                      ),
                      onChanged: (v) {
                        setState(() {
                          email = v;
                        });
                      },
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: FlatButton(
                      child: Text(
                        "Already have an account ?",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(PageTransition(
                            child: Login(), type: PageTransitionType.fade));
                      },
                    ),
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 1000),
                    margin: EdgeInsets.only(
                        left: 25, right: 25, top: height * 0.03, bottom: 2),
                    height: height * 0.08,
                    width: width * w,
                    decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.white),
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(50)),
                    child: FlatButton(
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                      },
                      child: type == 0
                          ? Text(
                              "Register",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            )
                          : type == 1
                              ? CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                )
                              : Icon(
                                  Icons.done,
                                  color: Colors.white,
                                  size: 28,
                                ),
                    ),
                  ),
                ],
              )),
        )),
      ),
    );
  }
}
