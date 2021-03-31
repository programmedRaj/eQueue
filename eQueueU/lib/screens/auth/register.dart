import 'dart:io';
import 'dart:ui';

import 'package:eQueue/components/color.dart';
import 'package:eQueue/constants/appcolor.dart';
import 'package:eQueue/screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final rkey = GlobalKey<FormState>();
  var w = 0.8;
  int type = 0;
  String name;
  String profile_url;
  String address1;
  String address2;
  String postalcode;
  String city;
  String province;
  String number;
  String error;
  String lang;
  int sizz = 0;
  File _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print(_image);
      } else {
        print('No image selected.');
      }
    });
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 50, bottom: 30),
                        child: Image.asset(
                          'lib/assets/logo.png',
                          height: height * 0.2,
                          width: width * 0.3,
                        ),
                      ),
                      _image == null
                          ? GestureDetector(
                              onTap: () {
                                getImage();
                              },
                              child: Container(
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundColor: myColor[150],
                                  child: Center(
                                    child: Icon(
                                      Icons.add_a_photo,
                                      color: myColor[100],
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : Center(
                              child: Container(
                                height: height * 0.15,
                                width: width * 0.28,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: FileImage(_image),
                                        fit: BoxFit.fill)),
                              ),
                            )
                    ],
                  ),
                  Container(
                    // height: sizz == 2 ? height * 0.12 : height * 0.08,
                    width: width,
                    margin: EdgeInsets.only(bottom: 15),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (name) {
                        if (name.isEmpty)
                          return 'Please Enter Name';
                        else
                          return null;
                      },
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
                          name = v;
                        });
                      },
                    ),
                  ),
                  Container(
                    // height: sizz == 2 ? height * 0.12 : height * 0.08,
                    margin: EdgeInsets.only(bottom: 15),
                    width: width,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (name) {
                        if (name.isEmpty)
                          return 'Please Enter Address 1';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Address 1",
                        hintStyle: TextStyle(
                            color: Colors
                                .white), //AppLocalization.of(context).nickname,
                        prefixIcon: Icon(
                          Icons.pin_drop_rounded,
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
                          address1 = v;
                        });
                      },
                    ),
                  ),
                  Container(
                    // height: sizz == 2 ? height * 0.12 : height * 0.08,
                    margin: EdgeInsets.only(bottom: 15),
                    width: width,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (name) {
                        if (name.isEmpty)
                          return 'Please Enter Address2';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Address 2",
                        hintStyle: TextStyle(
                            color: Colors
                                .white), //AppLocalization.of(context).nickname,
                        prefixIcon: Icon(
                          Icons.pin_drop_rounded,
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
                          address2 = v;
                        });
                      },
                    ),
                  ),
                  Container(
                    // height: sizz == 2 ? height * 0.12 : height * 0.08,
                    margin: EdgeInsets.only(bottom: 15),
                    width: width,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (name) {
                        if (name.isEmpty)
                          return 'Please Enter Postal Code';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Postal Code",
                        hintStyle: TextStyle(
                            color: Colors
                                .white), //AppLocalization.of(context).nickname,
                        prefixIcon: Icon(
                          Icons.contacts_rounded,
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
                          postalcode = v;
                        });
                      },
                    ),
                  ),
                  Container(
                    // height: sizz == 2 ? height * 0.12 : height * 0.08,
                    margin: EdgeInsets.only(bottom: 15),
                    width: width,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (name) {
                        if (name.isEmpty)
                          return 'Please Enter Province';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        hintText: "Province",
                        hintStyle: TextStyle(
                            color: Colors
                                .white), //AppLocalization.of(context).nickname,
                        prefixIcon: Icon(
                          Icons.location_history,
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
                          province = v;
                        });
                      },
                    ),
                  ),
                  Container(
                    // height: sizz == 2 ? height * 0.12 : height * 0.08,
                    margin: EdgeInsets.only(bottom: 15),
                    width: width,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (name) {
                        if (name.isEmpty)
                          return 'Please Enter City';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                        hintText: "City",
                        hintStyle: TextStyle(
                            color: Colors
                                .white), //AppLocalization.of(context).nickname,
                        prefixIcon: Icon(
                          Icons.location_city,
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
                          city = v;
                        });
                      },
                    ),
                  ),
                  Container(
                    // height: sizz == 2 ? height * 0.12 : height * 0.08,
                    margin: EdgeInsets.only(bottom: 15),
                    width: width,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Referal Code",
                        hintStyle: TextStyle(
                            color: Colors
                                .white), //AppLocalization.of(context).nickname,
                        prefixIcon: Icon(
                          Icons.pin_drop_rounded,
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
                          address2 = v;
                        });
                      },
                    ),
                  ),
                  IgnorePointer(
                    child: Container(
                      // height: sizz == 2 ? height * 0.12 : height * 0.08,
                      margin: EdgeInsets.only(bottom: 15),
                      width: width,
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Number",
                          hintStyle: TextStyle(
                              color: Colors
                                  .white), //AppLocalization.of(context).nickname,
                          prefixIcon: Icon(
                            Icons.contact_phone,
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
                            number = v;
                          });
                        },
                      ),
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
