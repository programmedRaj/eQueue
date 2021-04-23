import 'package:eQueue/check.dart';
import 'package:eQueue/components/color.dart';
import 'package:eQueue/screens/auth/login.dart';
import 'package:eQueue/screens/pages/settings/history.dart';
import 'package:eQueue/screens/pages/settings/langauge.dart';
import 'package:eQueue/screens/pages/settings/privacy_policy.dart';
import 'package:eQueue/screens/pages/settings/profile.dart';
import 'package:eQueue/screens/pages/settings/terms_conditions.dart';
import 'package:eQueue/screens/pages/walletpage/wallet_page.dart';
import 'package:eQueue/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => Profile()));
              },
              child: Container(
                margin: EdgeInsets.all(8),
                width: width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(10),
                    color: myColor[100],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                      )
                    ]),
                child: ListTile(
                  title: Text(LocaleKeys.MyInformation).tr(),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => History()));
              },
              child: Container(
                margin: EdgeInsets.all(8),
                width: width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(10),
                    color: myColor[100],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                      )
                    ]),
                child: ListTile(
                  title: Text(LocaleKeys.MyHistory).tr(),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => Language()));
              },
              child: Container(
                margin: EdgeInsets.all(8),
                width: width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(10),
                    color: myColor[100],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                      )
                    ]),
                child: ListTile(
                  title: Text(LocaleKeys.Language).tr(),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => Wallet()));
              },
              child: Container(
                margin: EdgeInsets.all(8),
                width: width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(10),
                    color: myColor[100],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                      )
                    ]),
                child: ListTile(
                  title: Text(LocaleKeys.Payments).tr(),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => TermsCondition()));
              },
              child: Container(
                margin: EdgeInsets.all(8),
                width: width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(10),
                    color: myColor[100],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                      )
                    ]),
                child: ListTile(
                  title: Text(LocaleKeys.TermsConditions).tr(),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => Policy()));
              },
              child: Container(
                margin: EdgeInsets.all(8),
                width: width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(10),
                    color: myColor[100],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                      )
                    ]),
                child: ListTile(
                  title: Text(LocaleKeys.PrivacyPolicy).tr(),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                logout();
              },
              child: Container(
                margin: EdgeInsets.all(8),
                width: width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(10),
                    color: myColor[100],
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey,
                      )
                    ]),
                child: ListTile(
                  title: Text(LocaleKeys.LogOut).tr(),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (BuildContext ctx) => Login()));
  }
}
