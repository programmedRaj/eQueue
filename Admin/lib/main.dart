import 'package:flutter/material.dart';

import 'pages/home/home.dart';
import 'widgets/color.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        iconTheme: IconThemeData(color: myColor[400]),
        primaryColor: myColor[300], //light indigo
        accentColor: myColor[100], //white
        highlightColor: myColor[400], //darkindigo
        hintColor: myColor[300], //black
        disabledColor: myColor[400], //grey
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
      initialRoute: '/',
      routes: {
        '/home': (context) => Home(),
        // '/login': (context) => Login(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    _check().then((value) => s());
  }

  Future s() async {
    Navigator.of(context).pushNamed('/home');
  }

  Future<bool> _check() async {
    await Future.delayed(Duration(milliseconds: 4000));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor.withOpacity(0.6),
      body: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'eQueue-Admin',
          ),
        ],
      )),
    );
  }
}
