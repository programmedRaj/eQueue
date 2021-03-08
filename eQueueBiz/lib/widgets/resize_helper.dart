import 'package:flutter/cupertino.dart';

class ResizeHelper {
  final BuildContext context;
  ResizeHelper({this.context});

  bool isDeskTop() => (MediaQuery.of(context).size.width > 1200) ? true : false;
}
