import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:page_transition/page_transition.dart';
import 'package:easy_localization/easy_localization.dart';

class Language extends StatefulWidget {
  @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  String lang;
  String _picked = "English";
  @override
  void initState() {
    // getlang();
    super.initState();
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
                if (_picked == 'English') {
                  context.setLocale(
                    Locale('en', 'US'),
                  );
                } else if (_picked == 'فارسی(Persian)') {
                  context.setLocale(
                    Locale('fa', 'FA'),
                  );
                } else if (_picked == 'عربی(Arabic)') {
                  context.setLocale(
                    Locale('ar', 'AR'),
                  );
                } else if (_picked == 'French') {
                  context.setLocale(
                    Locale('fr', 'FR'),
                  );
                } else if (_picked == 'Spanish') {
                  context.setLocale(
                    Locale('es', 'ES'),
                  );
                }
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
