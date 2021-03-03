import 'dart:html';

import 'package:equeue_admin/pages/home/desktopview/branch.dart';
import 'package:equeue_admin/pages/home/desktopview/company.dart';
import 'package:equeue_admin/pages/home/desktopview/employee.dart';
import 'package:equeue_admin/pages/home/desktopview/users.dart';
import 'package:equeue_admin/widgets/footer.dart';
import 'package:equeue_admin/widgets/valuedcontainer.dart';

import 'package:flutter/material.dart';

class DesktopHome extends StatefulWidget {
  @override
  _DesktopHomeState createState() => _DesktopHomeState();
}

class _DesktopHomeState extends State<DesktopHome> {
  int size = 0;
  bool statuss = false;
  String password;
  String password2;
  String error;
  final passwordkey = GlobalKey<FormState>();
  final notifikey = GlobalKey<FormState>();
  String notifititle;
  String notifimessage;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    if (width <= 1324) {
      size = 1;
    } else if (width <= 960) {
      size = 2;
    } else {
      size = 0;
    }
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('eQueue-Admin'),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          height: height,
          width: width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ValueContainer(
                          height,
                          width,
                          size,
                          'Company',
                          3,
                          Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          )),
                      ValueContainer(
                          height,
                          width,
                          size,
                          'Users',
                          3,
                          Icon(
                            Icons.person_add,
                            color: Colors.white,
                          )),
                      ValueContainer(
                          height,
                          width,
                          size,
                          'Branch',
                          3,
                          Icon(
                            Icons.shopping_basket,
                            color: Colors.white,
                          )),
                      ValueContainer(
                          height,
                          width,
                          size,
                          'Employee',
                          3,
                          Icon(
                            Icons.shopping_basket,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Container(
                        child: TabBar(
                            indicatorPadding: EdgeInsets.all(5),
                            unselectedLabelColor:
                                Theme.of(context).primaryColor,
                            labelColor: Theme.of(context).accentColor,
                            indicator: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10)),
                            tabs: [
                              Tab(
                                child: Text(
                                  'Companies',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Tab(
                                child: Text('Users',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Tab(
                                child: Text('Branches',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                              ),
                              Tab(
                                child: Text('Employee',
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ]),
                      ),
                      Container(
                        height: height,
                        width: width,
                        child: Container(
                          child: TabBarView(children: [
                            Container(child: Company()),
                            Container(child: Users()),
                            Container(child: Branch()),
                            Container(
                              child: Employee(),
                            )
                          ]),
                        ),
                      )
                    ],
                  ),
                ),
                Footer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
