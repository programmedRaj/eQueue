import 'dart:io';

import 'package:eQueue/api/models/userdetails.dart';
import 'package:eQueue/components/color.dart';
import 'package:eQueue/provider/user_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String address1;
  String address2;
  String city;
  String postalcode;
  String province;
  File image;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<UserDetails>(context, listen: false).getUserDet();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Consumer<UserDetails>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Profile'),
          ),
          body: value.users.length == 0 || value.users == null
              ? Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(myColor[150]),
                  ),
                )
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Column(
                          children: [
                            Container(
                              child: CircleAvatar(
                                radius: 70,
                                backgroundColor: myColor[50],
                              ),
                            ),
                            Container(
                              child: FlatButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Edit Photo',
                                    style: TextStyle(
                                      color: myColor[50],
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(15),
                        child: Form(
                            child: Column(
                          children: [
                            IgnorePointer(
                              child: Container(
                                margin: EdgeInsets.only(top: 20),
                                child: TextFormField(
                                  keyboardType: TextInputType.phone,
                                  initialValue: value.users[0].name,
                                  decoration: InputDecoration(
                                    hintText: 'Name',
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: myColor[250],
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
                                          color: myColor[50], width: 2.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: myColor[250], width: 2.0),
                                    ),
                                  ),
                                  onChanged: (v) {},
                                ),
                              ),
                            ),
                            IgnorePointer(
                              child: Container(
                                margin: EdgeInsets.only(top: 20),
                                child: TextFormField(
                                  keyboardType: TextInputType.phone,
                                  initialValue: value.users[0].phone,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.phone,
                                      color: myColor[250],
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
                                          color: myColor[50], width: 2.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: myColor[250], width: 2.0),
                                    ),
                                  ),
                                  onChanged: (v) {},
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                initialValue: value.users[0].address1,
                                decoration: InputDecoration(
                                  hintText: 'Address 1',
                                  prefixIcon: Icon(
                                    Icons.location_city,
                                    color: myColor[250],
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
                                        color: myColor[50], width: 2.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: myColor[250], width: 2.0),
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
                              margin: EdgeInsets.only(top: 20),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                initialValue: value.users[0].address2,
                                decoration: InputDecoration(
                                  hintText: 'Address 2',
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: myColor[250],
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
                                        color: myColor[50], width: 2.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: myColor[250], width: 2.0),
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
                              margin: EdgeInsets.only(top: 20),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                initialValue: value.users[0].province,
                                decoration: InputDecoration(
                                  hintText: 'Province',
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: myColor[250],
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
                                        color: myColor[50], width: 2.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: myColor[250], width: 2.0),
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
                              margin: EdgeInsets.only(top: 20),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                initialValue: value.users[0].city,
                                decoration: InputDecoration(
                                  hintText: 'City',
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: myColor[250],
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
                                        color: myColor[50], width: 2.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: myColor[250], width: 2.0),
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
                              margin: EdgeInsets.only(top: 20),
                              child: TextFormField(
                                keyboardType: TextInputType.text,
                                initialValue: value.users[0].postalcode,
                                decoration: InputDecoration(
                                  hintText: 'Postal Code',
                                  prefixIcon: Icon(
                                    Icons.phone,
                                    color: myColor[250],
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
                                        color: myColor[50], width: 2.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                        color: myColor[250], width: 2.0),
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
                              height: height * 0.06,
                              margin: EdgeInsets.all(15),
                              width: width,
                              decoration: BoxDecoration(
                                  color: myColor[50],
                                  borderRadius: BorderRadius.circular(10)),
                              child: FlatButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Update Profile',
                                    style: TextStyle(color: myColor[100]),
                                  )),
                            )
                          ],
                        )),
                      )
                    ],
                  ),
                ),
        );
      },
    );
  }
}
