import 'package:eQueue/check.dart';
import 'package:eQueue/components/color.dart';
import 'package:eQueue/screens/auth/login.dart';
import 'package:eQueue/screens/pages/settings/history.dart';
import 'package:eQueue/screens/pages/settings/langauge.dart';
import 'package:eQueue/screens/pages/settings/profile.dart';
import 'package:eQueue/screens/pages/walletpage/wallet_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
                  title: Text('My Information'),
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
                  title: Text('My History'),
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
                  title: Text('Language'),
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
                  title: Text('Payments'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (ctx) => Wallet()));
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
                  title: Text('Terms & Conditions'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                // Navigator.of(context)
                //     .push(MaterialPageRoute(builder: (ctx) => Wallet()));
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
                  title: Text('Privacy Policy'),
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
                  title: Text('Log Out'),
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
