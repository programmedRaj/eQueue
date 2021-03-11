import 'package:eQueue/components/color.dart';
import 'package:eQueue/screens/pages/companies_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int sizz;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    if (width <= 320.0) {
      setState(() {
        sizz = 1;
      });
    } else if (height <= 850) {
      setState(() {
        sizz = 2;
      });
    }
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              // search bar and info ----------------------------------------------------------------------------
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (ctx) => Company()));
                      },
                      child: Container(
                        height: height * 0.07,
                        width: width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: myColor[150],
                        ),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Search Companies',
                                style: TextStyle(
                                    color: myColor[250],
                                    fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.search,
                                color: myColor[250],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    // info
                    IconButton(
                        icon: Icon(
                          Icons.info,
                          color: myColor[250],
                          size: 30,
                        ),
                        onPressed: () {})
                  ],
                ),
              ),
              //----------------------------------------------------------------------------------------------------
              Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Hello Rushabh,',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                ),
              ),
              //----------------------------------------------------------------------------------------------------
              //------------------- Your Appointment-----------------------------------------------------------------
              Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20, left: 15, bottom: 20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Your Appointment',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: myColor[250]),
                      ),
                    ),
                    Container(
                      height: height * 0.4,
                      width: width,
                      child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 14,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (context, i) {
                            return GestureDetector(child: Card());
                          }),
                    ),
                  ],
                ),
              ),
              //--------------------------------------------------------------------------------------
              //----------------------------Your token-----------------------------------------------
              Container(
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20, left: 15, bottom: 20),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Your Tokens',
                        style: TextStyle(
                            fontWeight: FontWeight.w700, color: myColor[250]),
                      ),
                    ),
                    Container(
                      height: height * 0.5,
                      width: width,
                      child: GridView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 14,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2, childAspectRatio: 1 / 1.5),
                          itemBuilder: (context, i) {
                            return GestureDetector(
                              child: Card(
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          width: width * 0.5,
                                          padding: EdgeInsets.only(left: 8),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                  child: Text(
                                                'Company Name',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              )),
                                              Container(
                                                margin: EdgeInsets.only(top: 8),
                                                child: Text(
                                                  'Branch Name',
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(top: 8),
                                                alignment: Alignment.center,
                                                height: height * 0.04,
                                                width: width * 0.2,
                                                decoration: BoxDecoration(
                                                    color: myColor[150],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: Text(
                                                  'ABC112',
                                                  style: TextStyle(
                                                      color: myColor[250],
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(top: 4),
                                                child: Text('Date: 02/02/2021'),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(top: 4),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons.timer,
                                                      color: myColor[250],
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.02,
                                                    ),
                                                    Text(
                                                      '24:00',
                                                      style: TextStyle(
                                                          color: myColor[50],
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                          child: CircleAvatar(
                                        radius: 45,
                                        backgroundColor: myColor[50],
                                      )),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
