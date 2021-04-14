import 'package:eQueue/constants/apptoast.dart';
import 'package:eQueue/provider/payment_provider.dart';
import 'package:eQueue/provider/send_booking.dart';
import 'package:eQueue/provider/send_token.dart';
import 'package:eQueue/provider/user_details_provider.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';

import 'package:eQueue/components/color.dart';
import 'package:provider/provider.dart';

class PayFor extends StatefulWidget {
  final String companyname;
  final String branchname;
  final int branchid;
  final String servicename;
  final String servicerate;
  final String servicedess;
  final String time;
  final String date;
  PayFor({
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
  String insno;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Details'),
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CheckboxGroup(
                  labels: <String>["Insurance"],
                  onSelected: (val) {
                    setState(() {
                      isinsu = !isinsu;
                    });
                  }),
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
                          hintText: 'Insurance No.',
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Theme.of(context).errorColor,
                                width: 2.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: myColor[150], width: 2.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: myColor[150], width: 2.0),
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
                      color: Colors.grey[300],
                      blurRadius: 4,
                    )
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Details',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: height * 0.02),
                      child: Text(
                        'Company Name : ${widget.companyname}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: height * 0.01),
                      child: Text(
                        'Branch Name : ${widget.branchname}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: height * 0.01),
                      child: Text(
                        'Service Name : ${widget.servicename}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: height * 0.01),
                      child: Text(
                        'Date : ${widget.date}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: height * 0.01),
                      child: Text(
                        'Time Slot : ${widget.time}',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: height * 0.01),
                      child: Text(
                        'Service Rate : \$${widget.servicerate} ',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: height * 0.01),
                      child: Text(
                        'Service Description : ${widget.servicedess}',
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
      bottomNavigationBar: Container(
        height: height * 0.06,
        width: width,
        decoration: BoxDecoration(color: myColor[50]),
        child: FlatButton(
          onPressed: () async {
            var moneybonus =
                await Provider.of<UserDetails>(context, listen: false)
                    .getUserDet();
            print('---${moneybonus[1]}');

            var totalbonus = (int.parse(widget.servicerate) * 10) / 100;
            var totalbonustoint = double.parse(totalbonus.toStringAsFixed(2));

            if (double.parse(moneybonus[1]) >= totalbonustoint) {
              var totalservicecharge =
                  (int.parse(widget.servicerate) - totalbonustoint);
              if (double.parse(moneybonus[1]) >= totalservicecharge) {
                print('1. $totalservicecharge');
                var transid = Provider.of<PayProvider>(context, listen: false)
                    .getPayment(totalservicecharge, double.parse(moneybonus[1]),
                        'booking');
              } else {
                AppToast.showErr('Insufficient Balance');
              }
            } else if (totalbonustoint < moneybonus[1]) {
              var totalservicecharge =
                  (int.parse(widget.servicerate) - moneybonus[1]);
              if (double.parse(moneybonus[1]) >= totalservicecharge) {
                print('2. $totalservicecharge');
                var transid = Provider.of<PayProvider>(context, listen: false)
                    .getPayment(totalservicecharge, double.parse(moneybonus[1]),
                        'booking');
              } else {
                AppToast.showErr('Insufficient Balance');
              }
            } else if (double.parse(moneybonus[1]) == 0) {
              if (double.parse(moneybonus[1]) >=
                  double.parse(widget.servicerate)) {
                var transid = Provider.of<PayProvider>(context, listen: false)
                    .getPayment(double.parse(widget.servicerate),
                        double.parse(moneybonus[1]), 'booking');
              } else {
                AppToast.showErr('Insufficient Balance');
              }
            }

            // if (isinsu) {
            //   await Provider.of<SendBooking>(context, listen: false)
            //       .generatetoken(
            //     branchid: widget.branchid,
            //     branchname: widget.branchname,
            //     tokenorbooking: 'booking',
            //     insurance: insno,
            //     service: widget.servicename,
            //     slot: '${widget.date} - ${widget.time}',
            //   );
            // } else {
            //   print('wait');
            // }
          },
          child: isinsu
              ? Text(
                  'Book Now',
                  style: TextStyle(
                    color: myColor[100],
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                )
              : Text(
                  'Pay Now - \$${widget.servicerate}',
                  style: TextStyle(
                    color: myColor[100],
                    fontWeight: FontWeight.w800,
                    fontSize: 18,
                  ),
                ),
        ),
      ),
    );
  }
}
