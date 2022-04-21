import 'package:eQueue/check.dart';
import 'package:eQueue/components/color.dart';
import 'package:eQueue/constants/appcolor.dart';
import 'package:eQueue/constants/apptoast.dart';
import 'package:eQueue/provider/branch_provider.dart';
import 'package:eQueue/provider/delete_token_branch.dart';
import 'package:eQueue/provider/homescreentokbok.dart';
// import 'package:eQueue/provider/token_bookings_dikhao.dart';
import 'package:eQueue/screens/pages/companies_screen.dart';
import 'package:eQueue/screens/pages/mapss.dart';
import 'package:eQueue/screens/pages/settings/langauge.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:eQueue/translations/locale_keys.g.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int? sizz;
  String? token;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    callapi();
    gettoken();
  }

  var name;
  gettoken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      token = prefs.getString('token');
    });
  }

  callapi() {
    Provider.of<DisplayTokenBookHome>(context, listen: false)
        .displayboth('tokens', 'homescreen');
    Provider.of<DisplayTokenBookHome>(context, listen: false)
        .displayboth('bookings', 'homescreen');
  }

  Stream productsStream() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 10));
      callapi();

      yield null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    print(token);

    if (width <= 320.0) {
      setState(() {
        sizz = 1;
      });
    } else if (height <= 850) {
      setState(() {
        sizz = 2;
      });
    }
    return StreamBuilder(
      stream: productsStream(),
      builder: (context, snapshot) {
        return Consumer<DisplayTokenBookHome>(
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
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (ctx) => Company()));
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                            backgroundColor:
                                                Colors.orangeAccent,
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
                        child: token != null
                            ? Text(
                                '${LocaleKeys.hello.tr()}, ${JwtDecoder.decode(token!)["name"]}',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w700),
                              )
                            : Text(
                                '${LocaleKeys.hello.tr()}!',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w700),
                              ),
                      ),
                      //----------------------------------------------------------------------------------------------------
                      //------------------- Your Appointment-----------------------------------------------------------------
                      Container(
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            color: myColor[50]!.withOpacity(0.4),
                          )
                        ]),
                        child: Column(
                          children: [
                            Card(
                              child: ExpansionTile(
                                subtitle: Text(LocaleKeys.feereturn).tr(),
                                title: Text(
                                  LocaleKeys.yourbookings,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500),
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
                                                  Text(LocaleKeys.NoBookings)
                                                      .tr(),
                                                  Container(
                                                    height: height * 0.08,
                                                    margin: EdgeInsets.only(
                                                        top: 10),
                                                    decoration: BoxDecoration(
                                                        color: myColor[150],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: FlatButton(
                                                      child: Text(
                                                        LocaleKeys
                                                            .createbookings,
                                                        style: TextStyle(
                                                            color:
                                                                myColor[100]),
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
                                                return value.bookings.length ==
                                                        0
                                                    ? Container()
                                                    : Container(
                                                        height: height * 0.2,
                                                        width: width,
                                                        decoration:
                                                            BoxDecoration(
                                                                color: myColor[
                                                                    100],
                                                                boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors
                                                                          .grey[
                                                                      600]!,
                                                                  blurRadius: 4)
                                                            ]),
                                                        margin:
                                                            EdgeInsets.all(5),
                                                        child: Row(
                                                          children: [
                                                            Flexible(
                                                              child: Container(
                                                                width: width,
                                                                margin:
                                                                    EdgeInsets
                                                                        .all(5),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        // Text(value
                                                                        //     .bookings[index]
                                                                        //     .status),
                                                                        circle(value
                                                                            .bookings[index]
                                                                            .status)!,
                                                                        SizedBox(
                                                                          width:
                                                                              10,
                                                                        ),
                                                                        Container(
                                                                          child:
                                                                              Text('${LocaleKeys.Booking.tr()} : ${value.bookings[index].branchtable!.split("_")[0]}'),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Container(
                                                                      child: Text(
                                                                          '${LocaleKeys.Bookingon.tr()} : ${value.bookings[index].slots} '),
                                                                    ),
                                                                    Container(
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          Column(
                                                                            children: [
                                                                              Container(
                                                                                height: height * 0.07,
                                                                                width: width * 0.4,
                                                                                margin: EdgeInsets.only(top: 8),
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: myColor[150]),
                                                                                child: Center(
                                                                                  child: Text(
                                                                                    value.bookings[index].bookings!,
                                                                                    style: TextStyle(color: myColor[100], fontSize: 18, letterSpacing: 15, fontWeight: FontWeight.bold),
                                                                                  ),
                                                                                ),
                                                                              ),

                                                                              // Container(
                                                                              //   margin: EdgeInsets.only(top: 10),
                                                                              //   child: Text('${LocaleKeys.cureentpose.tr()} : ${value.bookings[index].waitlist}'),
                                                                              // ),
                                                                            ],
                                                                          ),
                                                                          Container(
                                                                            child: ElevatedButton(
                                                                                style: ButtonStyle(
                                                                                  backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                                                                ),
                                                                                onPressed: () {
                                                                                  showDialog(
                                                                                    context: context,
                                                                                    builder: (context) {
                                                                                      return AlertDialog(
                                                                                        title: Text("Delete"),
                                                                                        content: Text(LocaleKeys.Are_you_sure).tr(),
                                                                                        actions: [
                                                                                          ElevatedButton(
                                                                                              onPressed: () {
                                                                                                if (value.bookings[index].status == "ongoing") {
                                                                                                  AppToast.showErr('Booking is ongoing so cannot be cancelled');
                                                                                                } else {
                                                                                                  Provider.of<DeletetokenProvider>(context, listen: false).delettoken(
                                                                                                    branchname: value.bookings[index].branchtable,
                                                                                                    branchid: value.bookings[index].branchtable!.split('_')[1],
                                                                                                    tokennumber: value.bookings[index].bookings,
                                                                                                    tokenstatus: value.bookings[index].status,
                                                                                                    type: 'booking',
                                                                                                    price: value.bookings[index].price,
                                                                                                  );
                                                                                                  Provider.of<DisplayTokenBookHome>(context, listen: false).removebookinone(token: value.bookings[index].bookings);
                                                                                                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx) => Check()));
                                                                                                  AppToast.showSucc(LocaleKeys.Deleted.tr());
                                                                                                }
                                                                                              },
                                                                                              child: Text(LocaleKeys.Ok).tr()),
                                                                                          ElevatedButton(
                                                                                              onPressed: () {
                                                                                                Navigator.of(context).pop();
                                                                                              },
                                                                                              child: Text(LocaleKeys.Cancel).tr()),
                                                                                        ],
                                                                                      );
                                                                                    },
                                                                                  );
                                                                                },
                                                                                child: Text('Cancel')),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            )
                                                          ],
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
                            color: myColor[50]!.withOpacity(0.4),
                          )
                        ]),
                        child: Column(
                          children: [
                            Card(
                              child: ExpansionTile(
                                title: Text(
                                  LocaleKeys.yourtokens,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500),
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
                                                  Text(LocaleKeys.NoTokens)
                                                      .tr(),
                                                  Container(
                                                    height: height * 0.08,
                                                    margin: EdgeInsets.only(
                                                        top: 10),
                                                    decoration: BoxDecoration(
                                                        color: myColor[150],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: FlatButton(
                                                      child: Text(
                                                        LocaleKeys.createtoken,
                                                        style: TextStyle(
                                                            color:
                                                                myColor[100]),
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
                                              itemCount: value.tokens.length,
                                              itemBuilder: (context, index) {
                                                return value.tokens == null
                                                    ? Container()
                                                    : Dismissible(
                                                        direction:
                                                            DismissDirection
                                                                .endToStart,
                                                        key: UniqueKey(),
                                                        background: Container(
                                                          color: Colors.red,
                                                          child: Container(
                                                            margin:
                                                                EdgeInsets.all(
                                                                    10),
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .end,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .end,
                                                              children: [
                                                                Icon(
                                                                  Icons.delete,
                                                                  color:
                                                                      myColor[
                                                                          100],
                                                                ),
                                                                Text(
                                                                  LocaleKeys
                                                                      .Remove,
                                                                  style:
                                                                      TextStyle(
                                                                    color:
                                                                        myColor[
                                                                            100],
                                                                    fontSize:
                                                                        20,
                                                                  ),
                                                                ).tr(),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        onDismissed:
                                                            (direction) {
                                                          // Removes that item the list on swipwe
                                                          setState(() {
                                                            Provider.of<DeletetokenProvider>(context, listen: false).delettoken(
                                                                branchname: value
                                                                    .tokens[
                                                                        index]
                                                                    .branchtable,
                                                                branchid: value
                                                                    .tokens[
                                                                        index]
                                                                    .branchtable!
                                                                    .split(
                                                                        '_')[1],
                                                                tokennumber: value
                                                                    .tokens[
                                                                        index]
                                                                    .token,
                                                                tokenstatus: value
                                                                    .tokens[
                                                                        index]
                                                                    .status,
                                                                type: 'token');
                                                            Provider.of<DisplayTokenBookHome>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .removetokenone(
                                                                    token: value
                                                                        .tokens[
                                                                            index]
                                                                        .token);
                                                          });
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder: (ctx) =>
                                                                      Check()));
                                                          AppToast.showSucc(
                                                              LocaleKeys.Deleted
                                                                  .tr());
                                                        },
                                                        child: Container(
                                                          height: height * 0.25,
                                                          width: width,
                                                          decoration:
                                                              BoxDecoration(
                                                                  color:
                                                                      myColor[
                                                                          100],
                                                                  boxShadow: [
                                                                BoxShadow(
                                                                    color: Colors
                                                                            .grey[
                                                                        600]!,
                                                                    blurRadius:
                                                                        4)
                                                              ]),
                                                          margin:
                                                              EdgeInsets.all(5),
                                                          child: Container(
                                                            width: width * 0.4,
                                                            margin:
                                                                EdgeInsets.all(
                                                                    5),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    circle(value
                                                                        .tokens[
                                                                            index]
                                                                        .status)!,
                                                                    SizedBox(
                                                                      width: 10,
                                                                    ),
                                                                    Container(
                                                                      child: Text(value
                                                                          .tokens[
                                                                              index]
                                                                          .comp!),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Container(
                                                                  child: Text(value
                                                                      .tokens[
                                                                          index]
                                                                      .branchtable!
                                                                      .split(
                                                                          '_')[0]),
                                                                ),
                                                                value.tokens[index]
                                                                            .countnum ==
                                                                        null
                                                                    ? Container()
                                                                    : Container(
                                                                        child: Text(
                                                                            '${LocaleKeys.CounterNumber.tr()} : ${value.tokens[index].countnum}'),
                                                                      ),
                                                                Column(
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
                                                                              top: 8),
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              10),
                                                                          color:
                                                                              myColor[150]),
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Text(
                                                                          value
                                                                              .tokens[index]
                                                                              .token!,
                                                                          style: TextStyle(
                                                                              color: myColor[100],
                                                                              fontSize: 18,
                                                                              letterSpacing: 15,
                                                                              fontWeight: FontWeight.bold),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Column(
                                                                      children: [
                                                                        Container(
                                                                          child:
                                                                              Text('${LocaleKeys.cureentpose.tr()} : ${value.tokens[index].waitlist}'),
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
                                            )),
                                ],
                              ),
                            ),
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
      },
    );
  }

  Widget? circle(status) {
    if (status == 'onqueue') {
      return CircleAvatar(
        radius: 10,
        backgroundColor: Colors.amber,
      );
    } else if (status == 'call') {
      return CircleAvatar(
        radius: 10,
        backgroundColor: Colors.green,
      );
    } else {
      return null;
    }
  }
}
