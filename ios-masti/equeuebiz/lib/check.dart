import 'package:equeuebiz/constants/appcolor.dart';
import 'package:equeuebiz/providers/auth_prov.dart';
import 'package:equeuebiz/screens/homepage.dart';
import 'package:equeuebiz/screens/login_page.dart';
import 'package:equeuebiz/services/app_toast.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
    var email = prefs.getString('email');
    var pass = prefs.getString('pass');

    if (email == null) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (ctx) => LoginPage()));
    } else {
      Provider.of<AuthProv>(context, listen: false)
          .execLogin(email, pass)
          .then((value) {
        if (value) {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (ctx) => HomePage()));
        } else {
          AppToast.showErr("Problem logging");
        }
      });
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
