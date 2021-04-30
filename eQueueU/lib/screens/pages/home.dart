import 'package:eQueue/check.dart';
import 'package:eQueue/components/color.dart';
import 'package:eQueue/constants/appcolor.dart';
import 'package:eQueue/constants/apptoast.dart';
import 'package:eQueue/provider/branch_provider.dart';
import 'package:eQueue/provider/delete_token_branch.dart';
import 'package:eQueue/provider/token_bookings_dikhao.dart';
import 'package:eQueue/screens/pages/companies_screen.dart';
import 'package:eQueue/screens/pages/mapss.dart';
import 'package:eQueue/screens/pages/settings/langauge.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:eQueue/translations/locale_keys.g.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int sizz;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<DisplayTokenBook>(context, listen: false).displayboth('tokens');
    Provider.of<DisplayTokenBook>(context, listen: false)
        .displayboth('bookings');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {});
  }

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
    return Consumer<DisplayTokenBook>(
      builder: (context, value, child) {
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    LocaleKeys.searchcompanies,
                                    style: TextStyle(
                                        color: myColor[250],
                                        fontWeight: FontWeight.bold),
                                  ).tr(),
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
                        Row(children: [
                          PopupMenuButton<int>(
                            icon: Icon(
                              Icons.info,
                              color: myColor[150],
                              size: 30,
                            ),
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 1,
                                child: Row(
                                  children: [
                                    Container(
                                      child: CircleAvatar(
                                        radius: 10,
                                        backgroundColor: Colors.orangeAccent,
                                      ),
                                      // height: height * 0.02,
                                      // width: width * 0.04,
                                      // decoration: BoxDecoration(
                                      //     color: Colors.orangeAccent,
                                      //     borderRadius:
                                      //         BorderRadius.circular(20)),
                                    ),
                                    SizedBox(
                                      width: width * 0.02,
                                    ),
                                    Text(LocaleKeys.Onwait).tr(),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 2,
                                child: Row(
                                  children: [
                                    Container(
                                        child: CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Colors.green,
                                    )
                                        // height: height * 0.02,
                                        // width: width * 0.04,
                                        // decoration: BoxDecoration(
                                        //     color: Colors.green,
                                        //     borderRadius:
                                        //         BorderRadius.circular(20)),
                                        ),
                                    SizedBox(
                                      width: width * 0.02,
                                    ),
                                    Text(LocaleKeys.Call).tr(),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 3,
                                child: Row(
                                  children: [
                                    Container(
                                        child: CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Colors.blue,
                                    )

                                        // height: height * 0.02,
                                        // width: width * 0.04,
                                        // decoration: BoxDecoration(
                                        //     color: Colors.blue,
                                        //     borderRadius:
                                        //         BorderRadius.circular(20)),
                                        ),
                                    SizedBox(
                                      width: width * 0.02,
                                    ),
                                    Text(LocaleKeys.Completed).tr(),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                value: 4,
                                child: Row(
                                  children: [
                                    Container(
                                        child: CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Colors.red,
                                    )
                                        // height: height * 0.02,
                                        // width: width * 0.04,
                                        // decoration: BoxDecoration(
                                        //     color: Colors.red,
                                        //     borderRadius:
                                        //         BorderRadius.circular(20)),
                                        ),
                                    SizedBox(
                                      width: width * 0.02,
                                    ),
                                    Text(LocaleKeys.Cancel).tr(),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ]),
                      ],
                    ),
                  ),
                  //----------------------------------------------------------------------------------------------------
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${LocaleKeys.hello.tr()} Rushabh,',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    ),
                  ),
                  //----------------------------------------------------------------------------------------------------
                  //------------------- Your Appointment-----------------------------------------------------------------
                  Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: myColor[50].withOpacity(0.4),
                      )
                    ]),
                    child: Column(
                      children: [
                        Card(
                          child: ExpansionTile(
                            title: Text(
                              LocaleKeys.yourbookings,
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w500),
                            ).tr(),
                            children: <Widget>[
                              Container(
                                  height: height * 0.4,
                                  width: width,
                                  child: value.bookings == null ||
                                          value.bookings.isEmpty
                                      ? Container(
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: height * 0.1,
                                              ),
                                              Text(LocaleKeys.NoBookings).tr(),
                                              Container(
                                                height: height * 0.08,
                                                margin:
                                                    EdgeInsets.only(top: 10),
                                                decoration: BoxDecoration(
                                                    color: myColor[150],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: FlatButton(
                                                  child: Text(
                                                    LocaleKeys.createbookings,
                                                    style: TextStyle(
                                                        color: myColor[100]),
                                                  ).tr(),
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (ctx) =>
                                                                Company()));
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      : ListView.builder(
                                          itemCount: value.bookings.length,
                                          itemBuilder: (context, index) {
                                            return Dismissible(
                                              direction:
                                                  DismissDirection.endToStart,
                                              key: UniqueKey(),
                                              background: Container(
                                                color: Colors.red,
                                                child: Container(
                                                  margin: EdgeInsets.all(10),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Icon(
                                                        Icons.delete,
                                                        color: myColor[100],
                                                      ),
                                                      Text(
                                                        LocaleKeys.Remove,
                                                        style: TextStyle(
                                                          color: myColor[100],
                                                          fontSize: 20,
                                                        ),
                                                      ).tr(),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              onDismissed: (direction) {
                                                // Removes that item the list on swipwe
                                                setState(() {
                                                  Provider.of<DeletetokenProvider>(
                                                          context,
                                                          listen: false)
                                                      .delettoken(
                                                          branchname: value
                                                              .bookings[index]
                                                              .branchtable
                                                              .split('_')[0],
                                                          branchid: value
                                                              .bookings[index]
                                                              .branchtable
                                                              .split('_')[1],
                                                          tokennumber: value
                                                              .bookings[index]
                                                              .bookings,
                                                          tokenstatus: value
                                                              .bookings[index]
                                                              .status,
                                                          type: 'booking');
                                                  Provider.of<DisplayTokenBook>(
                                                          context,
                                                          listen: false)
                                                      .removebookinone(
                                                          token: value
                                                              .bookings[index]
                                                              .bookings);
                                                  Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (ctx) =>
                                                              Check()));
                                                  AppToast.showSucc(
                                                      LocaleKeys.Deleted.tr());
                                                });
                                                // Shows the information on Snackbar
                                              },
                                              child: Container(
                                                height: height * 0.2,
                                                width: width,
                                                decoration: BoxDecoration(
                                                    color: myColor[100],
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color:
                                                              Colors.grey[600],
                                                          blurRadius: 4)
                                                    ]),
                                                margin: EdgeInsets.all(5),
                                                child: Row(
                                                  children: [
                                                    Flexible(
                                                      child: Container(
                                                        width: width,
                                                        margin:
                                                            EdgeInsets.all(5),
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                  '${LocaleKeys.Booking.tr()} : ${value.bookings[index].branchtable.split("_")[0]}'),
                                                            ),
                                                            Container(
                                                              child: Text(
                                                                  '${LocaleKeys.Bookingon.tr()} : ${value.bookings[index].slots} '),
                                                            ),
                                                            Container(
                                                              child: Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .center,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .center,
                                                                children: [
                                                                  Container(
                                                                    height:
                                                                        height *
                                                                            0.07,
                                                                    width:
                                                                        width *
                                                                            0.4,
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                            top:
                                                                                8),
                                                                    decoration: BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                                10),
                                                                        color: myColor[
                                                                            150]),
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Text(
                                                                        value
                                                                            .bookings[index]
                                                                            .bookings,
                                                                        style: TextStyle(
                                                                            color: myColor[
                                                                                100],
                                                                            fontSize:
                                                                                18,
                                                                            letterSpacing:
                                                                                15,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),

                                                            // Container(
                                                            //   height: height * 0.07,
                                                            //   width: width * 0.4,
                                                            //   child: Center(
                                                            //     child: Text(
                                                            //       'Estimated Time : 10',
                                                            //       style: TextStyle(
                                                            //           fontWeight:
                                                            //               FontWeight
                                                            //                   .bold),
                                                            //     ),
                                                            //   ),
                                                            // ),
                                                            // Container(
                                                            //   child: Text(
                                                            //       'You are 4th in line'),
                                                            // )
                                                          ],
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  //--------------------------------------------------------------------------------------
                  //----------------------------Your token-----------------------------------------------
                  SizedBox(
                    height: height * 0.02,
                  ),
                  Container(
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: myColor[50].withOpacity(0.4),
                      )
                    ]),
                    child: Column(
                      children: [
                        Card(
                          child: ExpansionTile(
                            title: Text(
                              LocaleKeys.yourtokens,
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.w500),
                            ).tr(),
                            children: <Widget>[
                              Container(
                                  height: height * 0.4,
                                  width: width,
                                  child: value.tokens == null ||
                                          value.tokens.isEmpty
                                      ? Container(
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: height * 0.1,
                                              ),
                                              Text(LocaleKeys.NoTokens).tr(),
                                              Container(
                                                height: height * 0.08,
                                                margin:
                                                    EdgeInsets.only(top: 10),
                                                decoration: BoxDecoration(
                                                    color: myColor[150],
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                child: FlatButton(
                                                  child: Text(
                                                    LocaleKeys.createtoken,
                                                    style: TextStyle(
                                                        color: myColor[100]),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (ctx) =>
                                                                Company()));
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      : ListView.builder(
                                          itemCount: value.tokens.length,
                                          itemBuilder: (context, index) {
                                            return Dismissible(
                                              direction:
                                                  DismissDirection.endToStart,
                                              key: UniqueKey(),
                                              background: Container(
                                                color: Colors.red,
                                                child: Container(
                                                  margin: EdgeInsets.all(10),
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Icon(
                                                        Icons.delete,
                                                        color: myColor[100],
                                                      ),
                                                      Text(
                                                        LocaleKeys.Remove,
                                                        style: TextStyle(
                                                          color: myColor[100],
                                                          fontSize: 20,
                                                        ),
                                                      ).tr(),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              onDismissed: (direction) {
                                                // Removes that item the list on swipwe
                                                setState(() {
                                                  Provider.of<DeletetokenProvider>(
                                                          context,
                                                          listen: false)
                                                      .delettoken(
                                                          branchname: value
                                                              .tokens[index]
                                                              .branchtable
                                                              .split('_')[0],
                                                          branchid: value
                                                              .tokens[index]
                                                              .branchtable
                                                              .split('_')[1],
                                                          tokennumber: value
                                                              .tokens[index]
                                                              .token,
                                                          tokenstatus: value
                                                              .tokens[index]
                                                              .status,
                                                          type: 'token');
                                                  Provider.of<DisplayTokenBook>(
                                                          context,
                                                          listen: false)
                                                      .removetokenone(
                                                          token: value
                                                              .tokens[index]
                                                              .token);
                                                });
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (ctx) =>
                                                            Check()));
                                                AppToast.showSucc(
                                                    LocaleKeys.Deleted.tr());
                                              },
                                              child: Container(
                                                height: height * 0.2,
                                                width: width,
                                                decoration: BoxDecoration(
                                                    color: myColor[100],
                                                    boxShadow: [
                                                      BoxShadow(
                                                          color:
                                                              Colors.grey[600],
                                                          blurRadius: 4)
                                                    ]),
                                                margin: EdgeInsets.all(5),
                                                child: Container(
                                                  width: width * 0.4,
                                                  margin: EdgeInsets.all(5),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        child: Text(value
                                                            .tokens[index]
                                                            .comp),
                                                      ),
                                                      Container(
                                                        child: Text(value
                                                            .tokens[index]
                                                            .branchtable
                                                            .split('_')[0]),
                                                      ),
                                                      Container(
                                                        child: Text(
                                                            '${LocaleKeys.CounterNumber.tr()} : ${value.tokens[index].employeeid}'),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            height:
                                                                height * 0.07,
                                                            width: width * 0.4,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 8),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: myColor[
                                                                    150]),
                                                            child: Center(
                                                              child: Text(
                                                                value
                                                                    .tokens[
                                                                        index]
                                                                    .token,
                                                                style: TextStyle(
                                                                    color:
                                                                        myColor[
                                                                            100],
                                                                    fontSize:
                                                                        18,
                                                                    letterSpacing:
                                                                        15,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold),
                                                              ),
                                                            ),
                                                          ),
                                                          Column(
                                                            children: [
                                                              Container(
                                                                height: height *
                                                                    0.07,
                                                                width:
                                                                    width * 0.4,
                                                                child: Center(
                                                                  child: Text(
                                                                    '${LocaleKeys.EstimatedTime.tr()} : 10',
                                                                    style: TextStyle(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                child: Text(
                                                                    'You are 4th in line'),
                                                              ),
                                                            ],
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                  //  GridView.builder(
                                  //     itemCount: value.tokens.length,
                                  //     gridDelegate:
                                  //         SliverGridDelegateWithFixedCrossAxisCount(
                                  //             crossAxisCount: 2,
                                  //             childAspectRatio: 1 / 1.5),
                                  //     itemBuilder: (context, i) {
                                  //       return GestureDetector(
                                  //         child: Card(
                                  //           child: Container(
                                  //             padding: EdgeInsets.all(10),
                                  //             child: Row(
                                  //               mainAxisAlignment:
                                  //                   MainAxisAlignment
                                  //                       .spaceBetween,
                                  //               crossAxisAlignment:
                                  //                   CrossAxisAlignment
                                  //                       .center,
                                  //               children: [
                                  //                 Flexible(
                                  //                   child: Container(
                                  //                     width: width * 0.5,
                                  //                     padding:
                                  //                         EdgeInsets.only(
                                  //                             left: 8),
                                  //                     child: Column(
                                  //                       mainAxisAlignment:
                                  //                           MainAxisAlignment
                                  //                               .start,
                                  //                       crossAxisAlignment:
                                  //                           CrossAxisAlignment
                                  //                               .start,
                                  //                       children: [
                                  //                         Container(
                                  //                             child: Text(
                                  //                           'Company Name',
                                  //                           style: TextStyle(
                                  //                               fontSize:
                                  //                                   16,
                                  //                               fontWeight:
                                  //                                   FontWeight
                                  //                                       .bold),
                                  //                           maxLines: 1,
                                  //                           overflow:
                                  //                               TextOverflow
                                  //                                   .ellipsis,
                                  //                         )),
                                  //                         Container(
                                  //                           margin: EdgeInsets
                                  //                               .only(
                                  //                                   top: 8),
                                  //                           child: Text(
                                  //                             'Branch Name',
                                  //                             style: TextStyle(
                                  //                                 fontSize:
                                  //                                     14,
                                  //                                 fontWeight:
                                  //                                     FontWeight
                                  //                                         .w600),
                                  //                             maxLines: 1,
                                  //                             overflow:
                                  //                                 TextOverflow
                                  //                                     .ellipsis,
                                  //                           ),
                                  //                         ),
                                  //                         Container(
                                  //                           margin: EdgeInsets
                                  //                               .only(
                                  //                                   top: 8),
                                  //                           alignment:
                                  //                               Alignment
                                  //                                   .center,
                                  //                           height: height *
                                  //                               0.04,
                                  //                           width:
                                  //                               width * 0.2,
                                  //                           decoration: BoxDecoration(
                                  //                               color:
                                  //                                   myColor[
                                  //                                       150],
                                  //                               borderRadius:
                                  //                                   BorderRadius.circular(
                                  //                                       10)),
                                  //                           child: Text(
                                  //                             value
                                  //                                 .tokens[i]
                                  //                                 .token,
                                  //                             style: TextStyle(
                                  //                                 color: myColor[
                                  //                                     250],
                                  //                                 fontWeight:
                                  //                                     FontWeight
                                  //                                         .bold),
                                  //                           ),
                                  //                         ),
                                  //                         Container(
                                  //                           margin: EdgeInsets
                                  //                               .only(
                                  //                                   top: 4),
                                  //                           child: Text(
                                  //                               'Date: 02/02/2021'),
                                  //                         ),
                                  //                         Container(
                                  //                           margin: EdgeInsets
                                  //                               .only(
                                  //                                   top: 4),
                                  //                           child: Row(
                                  //                             children: [
                                  //                               Icon(
                                  //                                 Icons
                                  //                                     .timer,
                                  //                                 color: myColor[
                                  //                                     250],
                                  //                               ),
                                  //                               SizedBox(
                                  //                                 width: width *
                                  //                                     0.02,
                                  //                               ),
                                  //                               Text(
                                  //                                 '24:00',
                                  //                                 style: TextStyle(
                                  //                                     color: myColor[
                                  //                                         50],
                                  //                                     fontWeight:
                                  //                                         FontWeight.bold),
                                  //                               ),
                                  //                             ],
                                  //                           ),
                                  //                         )
                                  //                       ],
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //                 Container(
                                  //                     child: CircleAvatar(
                                  //                   radius: 45,
                                  //                   backgroundColor:
                                  //                       myColor[50],
                                  //                 )),
                                  //               ],
                                  //             ),
                                  //           ),
                                  //         ),
                                  //       );
                                  //     }
                                  // )
                                  ),
                            ],
                          ),
                        ),
                        // ElevatedButton(
                        //     onPressed: () {
                        //       Navigator.of(context).push(MaterialPageRoute(
                        //           builder: (ctx) => MapSample()));
                        //     },
                        //     child: child)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
      },
    );
  }
}
