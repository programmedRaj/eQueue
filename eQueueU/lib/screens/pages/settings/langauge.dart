import 'package:eQueue/check.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Language extends StatefulWidget {
  @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  String lang;
  String _picked;
  // @override
  // void initState() async {
  //   // getlang();
  //   super.initState();
  // }

  langs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _picked = prefs.getString('language');
    });
  }

  // getlang() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   setState(() {
  //     lang = prefs.getString('language');
  //     _picked = lang;
  //   });
  //   if (lang == 'French') {
  //     AppLocalization.load(Locale('fr', 'FR'));
  //   } else if (lang == 'Spanish') {
  //     AppLocalization.load(Locale('es', 'ES'));
  //   } else if (lang == 'فارسی(Persian)') {
  //     AppLocalization.load(Locale('fa', 'FA'));
  //   } else if (lang == 'عربی(Arabic)') {
  //     AppLocalization.load(Locale('ar', 'AR'));
  //   } else if (lang == 'English') {
  //     AppLocalization.load(Locale('en', 'US'));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    langs();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Language',
          ),
        ),
        body: Container(
            margin: EdgeInsets.only(top: 20),
            child: RadioButtonGroup(
              picked: _picked,
              onSelected: (String selected) async {
                setState(() {
                  _picked = selected;
                });
                setState(() async {
                  if (_picked == 'English') {
                    this.setState(() async {
                      context.setLocale(
                        Locale('en', 'US'),
                      );
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString('language', 'English');
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx) => Check()));
                    });
                  } else if (_picked == 'فارسی(Persian)') {
                    this.setState(() async {
                      context.setLocale(
                        Locale('fa', 'FA'),
                      );

                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();

                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (ctx) => Check()));
                      prefs.setString('language', 'فارسی(Persian)');
                    });
                  } else if (_picked == 'عربی(Arabic)') {
                    this.setState(() async {
                      context.setLocale(
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
                      context.setLocale(
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
                      context.setLocale(
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
                'فارسی(Persian)',
                'عربی(Arabic)',
                'French',
                'Spanish',
              ],
            )));
  }
}
