import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:page_transition/page_transition.dart';

class Language extends StatefulWidget {
  @override
  _LanguageState createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  String lang;
  String _picked;
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
