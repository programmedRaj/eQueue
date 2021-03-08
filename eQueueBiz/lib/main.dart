import 'package:equeuebiz/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'locale/app_localization.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final AppLocalizationDelegate _localeOverrideDelegate =
      AppLocalizationDelegate(Locale('en', 'US'));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        _localeOverrideDelegate
      ],
      supportedLocales: [
        const Locale('en', 'US'), //english
        const Locale('es', 'ES'), // spanish
        const Locale('ar', 'AR'), // Arabic
        const Locale('fr', 'FR'), // french
        const Locale('fa', 'FA'), // farsi
      ],
      title: 'Equeue Biz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}
