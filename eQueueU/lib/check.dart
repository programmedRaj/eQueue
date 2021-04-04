import 'package:eQueue/components/color.dart';
import 'package:eQueue/screens/auth/login.dart';
import 'package:eQueue/screens/home_screen.dart';
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
    return Scaffold(
      body: Container(
        child: Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(myColor[50]),
          ),
        ),
      ),
    );
  }
}
