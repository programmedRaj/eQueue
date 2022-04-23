import 'dart:async';

import 'package:eQueue/components/color.dart';
import 'package:eQueue/screens/auth/login.dart';
import 'package:eQueue/screens/home_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'translations/locale_keys.g.dart';

class Check extends StatefulWidget {
  @override
  _CheckState createState() => _CheckState();
}

class _CheckState extends State<Check> {
  @override
  void initState() {
    super.initState();

    _check().then((value) => s());
  }

  Future s() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    if (token == null) {
      Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => Login()));
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => MyHomePage()));
    }
  }

  Future<bool> _check() async {
    await Future.delayed(Duration(milliseconds: 1000));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPopp,
      child: Scaffold(
        body: Container(
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(myColor[50]),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> onWillPopp() async {
    return showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text(LocaleKeys.Are_you_sure).tr(),
            content: new Text(LocaleKeys.Do_you_want_to_exit_an_App).tr(),
            actions: <Widget>[
              new GestureDetector(
                onTap: () => Navigator.of(context).pop(false),
                child: Text(LocaleKeys.NO).tr(),
              ),
              SizedBox(height: 16),
              new GestureDetector(
                onTap: () {
                  SystemNavigator.pop();
                },
                child: Text(LocaleKeys.YES).tr(),
              ),
            ],
          ),
        ) as FutureOr<bool>? ??
        false;
  }
}
