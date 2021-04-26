import 'package:flutter/material.dart';

class UserDets extends StatefulWidget {
  @override
  _UserDetsState createState() => _UserDetsState();
}

class _UserDetsState extends State<UserDets> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Details'),
      ),
    );
  }
}
