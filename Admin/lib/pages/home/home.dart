import 'package:equeue_admin/pages/home/deskstophome.dart';
import 'package:equeue_admin/pages/home/mobilehome.dart';
import 'package:equeue_admin/pages/home/tabhome.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: MobileHome(),
      desktop: DesktopHome(),
      //tablet: TabHome(),
    );
  }
}
