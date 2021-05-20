import 'dart:io';

import 'package:eQueue/api/models/userdetails.dart';
import 'package:eQueue/components/color.dart';
import 'package:eQueue/provider/update_userdetails.dart';
import 'package:eQueue/provider/user_details_provider.dart';
import 'package:eQueue/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

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
  File _image;
  final picker = ImagePicker();
  UserDets userDets;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (userDets == null) {
      Provider.of<UserDetails>(context, listen: false).getUserDet();
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
    return Consumer<UserDetails>(
      builder: (context, value, child) {
        if (value.userd.isNotEmpty) {
          userDets = value.userd[0];
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(LocaleKeys.Profile).tr(),
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
                      SizedBox(
                        height: 30,
                      ),
                      _image == null
                          ? value.users[0].profileurl == 'null'
                              ? Container(
                                  margin: EdgeInsets.only(top: 30),
                                  child: Column(
                                    children: [
                                      Container(
                                        child: CircleAvatar(
                                          radius: 70,
                                          backgroundColor: myColor[50],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 60,
                                  backgroundImage: NetworkImage(
                                      'https://www.nobatdeh.com/uploads/usersprofile/' +
                                          '${value.users[0].profileurl}'),
                                )
                          : CircleAvatar(
                              radius: 60,
                              backgroundImage: FileImage(_image),
                            ),
                      Container(
                        child: FlatButton(
                            onPressed: () {
                              getImage();
                            },
                            child: Text(
                              LocaleKeys.EditPhoto,
                              style: TextStyle(
                                color: myColor[50],
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ).tr()),
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
                                    hintText: LocaleKeys.Name.tr(),
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
                                initialValue:
                                    value.users[0].address1 == 'optional'
                                        ? null
                                        : value.users[0].address1,
                                decoration: InputDecoration(
                                  hintText: LocaleKeys.Address1.tr(),
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
                                initialValue:
                                    value.users[0].address2 == 'optional'
                                        ? null
                                        : value.users[0].address2,
                                decoration: InputDecoration(
                                  hintText: LocaleKeys.Address2.tr(),
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
                                initialValue:
                                    value.users[0].province == 'optional'
                                        ? null
                                        : value.users[0].province,
                                decoration: InputDecoration(
                                  hintText: LocaleKeys.Province.tr(),
                                  prefixIcon: Icon(
                                    Icons.post_add,
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
                                initialValue: value.users[0].city == 'optional'
                                    ? null
                                    : value.users[0].city,
                                decoration: InputDecoration(
                                  hintText: LocaleKeys.City.tr(),
                                  prefixIcon: Icon(
                                    Icons.mobile_friendly,
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
                                initialValue:
                                    value.users[0].postalcode == 'optional'
                                        ? null
                                        : value.users[0].postalcode,
                                decoration: InputDecoration(
                                  hintText: LocaleKeys.PostalCode.tr(),
                                  prefixIcon: Icon(
                                    Icons.mail,
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
                                  onPressed: () {
                                    Provider.of<UpUserDetails>(context,
                                            listen: false)
                                        .upUserDet(
                                      _image,
                                      address1,
                                      address2,
                                      city,
                                      postalcode,
                                      province,
                                    )
                                        .then((value) {
                                      Provider.of<UserDetails>(context,
                                              listen: false)
                                          .getUserDet();
                                      setState(() {});
                                      Navigator.of(context).pop();
                                    });
                                  },
                                  child: Text(
                                    LocaleKeys.UpdateProfile,
                                    style: TextStyle(color: myColor[100]),
                                  ).tr()),
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
