import 'package:equeuebiz/constants/appcolor.dart';
import 'package:equeuebiz/screens/homepage.dart';
import 'package:equeuebiz/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    var token = prefs.getString('email');

    if (token == null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => LoginPage()));
    } else {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => HomePage()));
    }
  }

  Future<bool> _check() async {
    await Future.delayed(Duration(milliseconds: 1000));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(AppColor.mainBlue),
          ),
        ),
      ),
    );
  }
}
