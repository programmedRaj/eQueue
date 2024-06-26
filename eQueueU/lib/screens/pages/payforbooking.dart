import 'dart:async';

import 'package:eQueue/check.dart';
import 'package:eQueue/constants/apptoast.dart';
import 'package:eQueue/provider/payment_provider.dart';
import 'package:eQueue/provider/send_booking.dart';
import 'package:eQueue/provider/send_token.dart';
import 'package:eQueue/provider/user_details_provider.dart';
import 'package:eQueue/screens/home_screen.dart';
import 'package:eQueue/screens/pages/home.dart';
import 'package:eQueue/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons_ns/grouped_buttons_ns.dart';

import 'package:eQueue/components/color.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class PayFor extends StatefulWidget {
  final String? companyname;
  final String? branchname;
  final int? branchid;
  final String? servicename;
  final String? servicerate;
  final String? servicedess;
  final String? time;
  final String? ins;
  final String? date;
  final String? compid;
  PayFor({
    this.compid,
    this.ins,
    this.companyname,
    this.branchname,
    this.branchid,
    this.servicename,
    this.servicerate,
    this.servicedess,
    this.time,
    this.date,
  });

  @override
  _PayForState createState() => _PayForState();
}

class _PayForState extends State<PayFor> {
  bool isinsu = false;
  String? insno;
  String? transid;
  bool onepress = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    print(widget.ins);

    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.PaymentDetails.tr()),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (ctx) => Check()));
              },
              icon: Icon(Icons.home))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.ins == '1'
                  ? CheckboxGroup(
                      labels: <String>[LocaleKeys.Insurance.tr()],
                      onSelected: (val) {
                        setState(() {
                          isinsu = !isinsu;
                        });
                      })
                  : Container(),
              isinsu
                  ? Container(
                      margin: EdgeInsets.all(10),
                      child: TextField(
                        onChanged: (v) {
                          setState(() {
                            insno = v;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: LocaleKeys.InsuranceNo.tr(),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Theme.of(context).errorColor,
                                width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: myColor[150]!, width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: myColor[150]!, width: 2.0),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              Container(
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.all(10),
                width: width,
                decoration: BoxDecoration(
                  color: myColor[100],
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey[300]!,
                      blurRadius: 4,
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.Details,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ).tr(),
                    Container(
                      margin: EdgeInsets.only(top: height * 0.02),
                      child: Text(
                        '${LocaleKeys.CompanyName.tr()} : ${widget.companyname}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: height * 0.01),
                      child: Text(
                        '${LocaleKeys.BranchName.tr()} : ${widget.branchname}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: height * 0.01),
                      child: Text(
                        '${LocaleKeys.ServiceName.tr()} : ${widget.servicename}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: height * 0.01),
                      child: Text(
                        '${LocaleKeys.Date.tr()} : ${widget.date}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: height * 0.01),
                      child: Text(
                        '${LocaleKeys.ScheduleTime.tr()} : ${widget.time}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: height * 0.01),
                      child: Text(
                        '${LocaleKeys.ServiceRate.tr()} : \$${widget.servicerate} ',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: height * 0.01),
                      child: Text(
                        '${LocaleKeys.ServiceDescription.tr()} : ${widget.servicedess}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ]),
      ),
      bottomNavigationBar: isinsu
          ? Container(
              height: height * 0.06,
              width: width,
              decoration:
                  BoxDecoration(color: onepress ? Colors.grey : myColor[50]),
              child: onepress
                  ? IgnorePointer(
                      child: FlatButton(
                        child: Text(
                          LocaleKeys.BookNow,
                          style: TextStyle(
                            color: myColor[100],
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () {
                          print('cant Book');
                        },
                      ),
                    )
                  : FlatButton(
                      child: Text(
                        LocaleKeys.BookNow,
                        style: TextStyle(
                          color: myColor[100],
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                          onepress = true;
                        });

                        await Provider.of<SendBooking>(context, listen: false)
                            .generatetoken(
                          company: widget.companyname,
                          branchid: widget.branchid,
                          branchname: widget.branchname,
                          tokenorbooking: 'booking',
                          insurance: insno,
                          service: widget.servicename,
                          slot: '${widget.date} - ${widget.time}',
                          isno: isinsu,
                          price: widget.servicerate,
                        )
                            .then((value) {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (ctx) => Check()));
                        });
                        setState(() {
                          onepress = true;
                        });
                      },
                    ),
            )
          : Container(
              height: height * 0.06,
              width: width,
              decoration:
                  BoxDecoration(color: onepress ? Colors.grey : myColor[50]),
              child: onepress
                  ? IgnorePointer(
                      child: FlatButton(
                        child: Text(
                          '${LocaleKeys.PayNow.tr()} - \$${widget.servicerate}',
                          style: TextStyle(
                            color: myColor[100],
                            fontWeight: FontWeight.w800,
                            fontSize: 18,
                          ),
                        ),
                        onPressed: () {
                          print('cant Pay');
                        },
                      ),
                    )
                  : FlatButton(
                      child: Text(
                        '${LocaleKeys.PayNow.tr()} - \$${widget.servicerate}',
                        style: TextStyle(
                          color: myColor[100],
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                      onPressed: () async {
                        setState(() {
                          onepress = true;
                        });
                        var moneybonus = await Provider.of<UserDetails>(context,
                                listen: false)
                            .getUserDet();
                        monbon(moneybonus[0], moneybonus[1], widget.compid)
                            .then((value) async {
                          if (!isinsu) {
                            await Provider.of<SendBooking>(context,
                                    listen: false)
                                .generatetoken(
                              branchid: widget.branchid,
                              company: widget.companyname,
                              branchname: widget.branchname,
                              tokenorbooking: 'booking',
                              insurance: value,
                              service: widget.servicename,
                              slot: '${widget.date} - ${widget.time}',
                              isno: isinsu,
                              price: widget.servicerate,
                            );
                          }
                          setState(() {
                            onepress = true;
                          });
                        }).then((value) {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (ctx) => Check()));
                        });
                      },
                    ),
            ),
      // bottomNavigationBar: Container(
      // height: height * 0.06,
      // width: width,
      // decoration: BoxDecoration(color: onepress ? Colors.grey : myColor[50]),
      //   child: onepress
      //       ? FlatButton(
      //           onPressed: () {
      //             print('pressed');
      //           },
      //           child: isinsu
      //               ? Text(
      //                   LocaleKeys.BookNow,
      //                   style: TextStyle(
      //                     color: myColor[100],
      //                     fontWeight: FontWeight.w800,
      //                     fontSize: 18,
      //                   ),
      //                 ).tr()
      //               : Text(
      //                   '${LocaleKeys.PayNow.tr()} - \$${widget.servicerate}',
      //                   style: TextStyle(
      //                     color: myColor[100],
      //                     fontWeight: FontWeight.w800,
      //                     fontSize: 18,
      //                   ),
      //                 ),
      //         )
      //       : FlatButton(
      //           onPressed: () async {
      // var moneybonus =
      //     await Provider.of<UserDetails>(context, listen: false)
      //         .getUserDet();
      //             print('---${moneybonus[1]}');
      //             print(isinsu);
      //             setState(() {
      //               onepress = true;
      //             });
      //             print(onepress);

      //             if (isinsu) {
      // await Provider.of<SendBooking>(context, listen: false)
      //     .generatetoken(
      //   company: widget.companyname,
      //   branchid: widget.branchid,
      //   branchname: widget.branchname,
      //   tokenorbooking: 'booking',
      //   insurance: insno,
      //   service: widget.servicename,
      //   slot: '${widget.date} - ${widget.time}',
      //   isno: isinsu,
      //   price: widget.servicerate,
      // )
      //     .then((value) {
      //   Navigator.of(context)
      //       .push(MaterialPageRoute(builder: (ctx) => Check()));
      // });
      // setState(() {
      //   onepress = true;
      // });
      //             }
      //             if (!isinsu)
      // monbon(moneybonus[0], moneybonus[1], widget.compid)
      //     .then((value) async {
      //   if (!isinsu) {
      //     await Provider.of<SendBooking>(context, listen: false)
      //         .generatetoken(
      //       branchid: widget.branchid,
      //       company: widget.companyname,
      //       branchname: widget.branchname,
      //       tokenorbooking: 'booking',
      //       insurance: value,
      //       service: widget.servicename,
      //       slot: '${widget.date} - ${widget.time}',
      //       isno: isinsu,
      //       price: widget.servicerate,
      //     );
      //   }
      //   setState(() {
      //     onepress = true;
      //   });
      // }).then((value) {
      //   Navigator.of(context)
      //       .push(MaterialPageRoute(builder: (ctx) => Check()));
      // });
      //           },
      //           child: isinsu
      //               ? Text(
      //                   LocaleKeys.BookNow,
      //                   style: TextStyle(
      //                     color: myColor[100],
      //                     fontWeight: FontWeight.w800,
      //                     fontSize: 18,
      //                   ),
      //                 ).tr()
      //               : Text(
      //                   '${LocaleKeys.PayNow.tr()} - \$${widget.servicerate}',
      // style: TextStyle(
      //   color: myColor[100],
      //   fontWeight: FontWeight.w800,
      //   fontSize: 18,
      // ),
      //                 ),
      //         ),
      // ),
    );
  }

  Future monbon(String? money, String bonus, String? compid) async {
    var totalbonus = (int.parse(widget.servicerate!) * 10) / 100;
    var totalbonustoint = double.parse(totalbonus.toStringAsFixed(2));

    if (double.parse(bonus) >= totalbonustoint) {
      var totalservicecharge =
          (int.parse(widget.servicerate!) - totalbonustoint);
      if (double.parse(money!) >= totalservicecharge) {
        print('1. $totalservicecharge');
        var transid = Provider.of<PayProvider>(context, listen: false)
            .getPayment(
                totalservicecharge, double.parse(bonus), 'booking', compid);
        return transid;
      } else {
        AppToast.showErr(LocaleKeys.InsufficientBalance.tr());
      }
    } else if (totalbonustoint < double.parse(bonus)) {
      var totalservicecharge =
          (int.parse(widget.servicerate!) - double.parse(bonus));
      if (double.parse(money!) >= totalservicecharge) {
        print('2. $totalservicecharge');
        var transid = Provider.of<PayProvider>(context, listen: false)
            .getPayment(
                totalservicecharge, double.parse(bonus), 'booking', compid);

        return transid;
      } else {
        AppToast.showErr(LocaleKeys.InsufficientBalance.tr());
      }
    } else if (double.parse(bonus) == 0) {
      if (double.parse(money!) >= double.parse(widget.servicerate!)) {
        var transid = Provider.of<PayProvider>(context, listen: false)
            .getPayment(double.parse(widget.servicerate!), double.parse(bonus),
                'booking', compid);
        return transid;
      } else {
        AppToast.showErr(LocaleKeys.InsufficientBalance.tr());
      }
    }
  }
}
