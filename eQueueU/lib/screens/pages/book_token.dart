import 'package:eQueue/components/color.dart';
import 'package:eQueue/components/tokenpage.dart';
import 'package:flutter/material.dart';

class Bookappointment extends StatefulWidget {
  @override
  _BookappointmentState createState() => _BookappointmentState();
}

class _BookappointmentState extends State<Bookappointment> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text('Time Slot'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: myColor[50],
                      ),
                    ),
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.only(left: 5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Text(
                                'Enr. Raj Shah',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 3),
                              child: Text(
                                'Specialized in Flask',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 3),
                              child: Text(
                                '4 Years Of Experience',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  color: myColor[50],
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 3),
                              child: Text(
                                '\$40',
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: FlatButton(
                        child: Text(
                          'View Profile',
                          style: TextStyle(color: myColor[50]),
                        ),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: width,
                child: TokenPage(),
              )
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: height * 0.06,
          margin: EdgeInsets.all(15),
          width: width,
          decoration: BoxDecoration(
              color: myColor[50], borderRadius: BorderRadius.circular(10)),
          child: FlatButton(
              onPressed: () {},
              child: Text(
                'Generate Token',
                style: TextStyle(color: myColor[100]),
              )),
        ));
  }
}
