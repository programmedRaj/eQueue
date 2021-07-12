import 'package:equeuebiz/constants/appcolor.dart';
import 'package:equeuebiz/screens/change_password.dart';
import 'package:equeuebiz/screens/login_page.dart';
import 'package:equeuebiz/translations/locale_keys.g.dart';
import 'package:equeuebiz/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

import '../check.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  String lang;
  String _picked;

  langs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _picked = prefs.getString('language');
    });
  }

  List<String> languagesList = [
    'English',
    'Hindi',
    'عربی(Arabic)',
    'French',
    'Spanish',
  ];
  String _chosenLanguage = "English";
  @override
  Widget build(BuildContext context) {
    langs();
    return Scaffold(
      appBar: whiteAppBar(context, "Settings"),
      body: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 1200),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            _languageDropdown(),
            SizedBox(
              height: 20,
            ),
            _changePass(),
            SizedBox(
              height: 20,
            ),
            _logOut()
          ],
        ),
      ),
    );
  }

  Widget _languageDropdown() {
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: RadioButtonGroup(
          activeColor: AppColor.mainBlue,
          picked: _picked,
          onSelected: (String selected) async {
            setState(() {
              _picked = selected;
            });
            setState(() async {
              if (_picked == 'English') {
                this.setState(() async {
                  await context.setLocale(
                    Locale('en', 'US'),
                  );
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString('language', 'English');

                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => Check()));
                });
              } else if (_picked == 'Hindi') {
                this.setState(() async {
                  await context.setLocale(
                    Locale('hi', 'IN'),
                  );

                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => Check()));
                  prefs.setString('language', 'Hindi');
                });
              } else if (_picked == 'عربی(Arabic)') {
                this.setState(() async {
                  await context.setLocale(
                    Locale('ar', 'AR'),
                  );
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();

                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => Check()));
                  prefs.setString('language', 'عربی(Arabic)');
                });
              } else if (_picked == 'French') {
                this.setState(() async {
                  await context.setLocale(
                    Locale('fr', 'FR'),
                  );
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString('language', 'French');

                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => Check()));
                });
              } else if (_picked == 'Spanish') {
                this.setState(() async {
                  await context.setLocale(
                    Locale('es', 'ES'),
                  );
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString('language', 'Spanish');

                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => Check()));
                });
              }
            });
          },
          labels: <String>[
            'English',
            'Hindi',
            'عربی(Arabic)',
            'French',
            'Spanish',
          ],
        ));
  }

  Widget _changePass() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChangePassword(),
            ));
      },
      child: Text(LocaleKeys.Change_Password.tr()),
    );
  }

  Widget _logOut() {
    return Container(
      height: 40,
      color: Colors.red,
      child: FlatButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => LoginPage(),
              ),
              (route) => false);
        },
        child: Text(
          LocaleKeys.LogOut.tr(),
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
