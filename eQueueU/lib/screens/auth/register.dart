import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:country_calling_code_picker/picker.dart';
import 'package:eQueue/api/service/baseurl.dart';
import 'package:eQueue/components/color.dart';
import 'package:eQueue/constants/appcolor.dart';
import 'package:eQueue/screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';

import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  Country _selectedCountry;
  String phone;
  String referralcode;
  File _image;
  final picker = ImagePicker();
  BaseUrl baseUrl = BaseUrl();

  @override
  void initState() {
    super.initState();
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

  Future register({
    String name,
    File images,
    String phonenumber,
    String address1,
    String address2,
    String city,
    String postalcode,
    String province,
    String countrycode,
    String referralcode,
  }) async {
    Uri registeruri = Uri.parse(baseUrl.register);
    var header = {
      'Content-Type': 'multipart/form-data',
    };
    var request = new http.MultipartRequest("POST", registeruri)
      ..headers.addAll(header);

    request.files
        .add(await http.MultipartFile.fromPath('profile_img', images.path));

    request.fields['name'] = name;
    request.fields['number'] = countrycode.substring(1) + phonenumber;
    request.fields['phonenumber'] = phonenumber;
    request.fields['address1'] = address1;
    request.fields['address2'] = address2;
    request.fields['province'] = province;
    request.fields['city'] = city;
    request.fields['postalcode'] = postalcode;
    request.fields['countrycode'] = countrycode;
    request.fields['referral_code'] = phonenumber + '@equeue';
    var res = await request.send();

    var response = await http.Response.fromStream(res);
    if (res.statusCode == 200) {
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => Login()));
    } else if (res.statusCode == 403) {
      error = 'You Already Have an Account';
    } else {
      setState(() {
        error = 'Something went wrong';
      });
    }
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
                          referralcode = v;
                        });
                      },
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: height * 0.035),
                          height: sizz == 2 ? height * 0.06 : height * 0.03,
                          width: width / 5.5,
                          child: ElevatedButton(
                            child: _selectedCountry == null
                                ? Text('+',
                                    style: TextStyle(color: myColor[100]))
                                : Text(
                                    '${_selectedCountry?.callingCode ?? '+code'}',
                                    style: TextStyle(color: myColor[100]),
                                  ),
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
                  error == null ? Container() : Text(error),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 1000),
                    margin: EdgeInsets.only(
                        left: 25, right: 25, top: height * 0.01, bottom: 2),
                    height: height * 0.08,
                    width: width * w,
                    decoration: BoxDecoration(
                        border: Border.all(width: 4, color: Colors.white),
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(50)),
                    child: TextButton(
                      onPressed: () async {
                        FocusScope.of(context).unfocus();
                        if (rkey.currentState.validate()) {
                          if (_image != null) {
                            register(
                              name: name,
                              images: _image,
                              address1: address1,
                              address2: address2,
                              city: city,
                              province: province,
                              countrycode: _selectedCountry.callingCode,
                              phonenumber: phone,
                              postalcode: postalcode,
                              referralcode: referralcode,
                            );
                          } else {
                            error = "Please Select An Image";
                          }
                        }
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
