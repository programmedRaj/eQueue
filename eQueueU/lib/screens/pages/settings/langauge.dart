import 'package:eQueue/check.dart';
import 'package:eQueue/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons_ns/grouped_buttons_ns.dart';
import 'package:page_transition/page_transition.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:easy_localization/easy_localization.dart';

class Language extends StatefulWidget {
  @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  String? lang;
  String? _picked;
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
            LocaleKeys.Language,
          ).tr(),
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
            )));
  }
}
