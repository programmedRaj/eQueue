import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  final String url = 'https://freeloc.in/';
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      height: height * 0.07,
      width: width,
      color: Theme.of(context).primaryColor,
      child: Center(
          child: GestureDetector(
        onTap: () async {
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        },
        child: Text(
          '© Copyright Freeloc IT Solutions 2020-2021',
          style: TextStyle(color: Theme.of(context).accentColor),
        ),
      )),
    );
  }
}
