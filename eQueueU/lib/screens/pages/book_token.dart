import 'dart:convert';

import 'package:eQueue/components/color.dart';
import 'package:eQueue/components/tokenpage.dart';
import 'package:eQueue/constants/apptoast.dart';
import 'package:eQueue/provider/department_token_provider.dart';
import 'package:eQueue/provider/send_token.dart';
import 'package:eQueue/provider/token_check_provider.dart';
import 'package:eQueue/screens/home_screen.dart';
import 'package:eQueue/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class Booktoken extends StatefulWidget {
  final int id;
  final int bid;
  final String type;
  final String branchname;
  final String companyname;
  final String wk;
  Booktoken(
      {this.id,
      this.bid,
      this.type,
      this.branchname,
      this.companyname,
      this.wk});
  @override
  _BooktokenState createState() => _BooktokenState();
}

class _BooktokenState extends State<Booktoken> {
  String dropval;
  bool onpress = false;
  int whichday;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<DepProvider>(context, listen: false).getdep(
      bid: widget.bid,
      id: widget.id,
      type: widget.type,
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Consumer<DepProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(LocaleKeys.createtoken).tr(),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Container(
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
                    margin: EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                            '${LocaleKeys.BranchType.tr()} : ${widget.type}',
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: width,
                  child: Column(
                    children: [
                      Container(
                        width: width,
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).accentColor, width: 1),
                            borderRadius: BorderRadius.circular(10)),
                        padding: EdgeInsets.all(10),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton(
                              items: value.departs.map((val) {
                                return new DropdownMenuItem<String>(
                                  value: val,
                                  child: new Text(val),
                                );
                              }).toList(),
                              hint: dropval == null
                                  ? Container(
                                      width: width * 0.45,
                                      child: Text(
                                        LocaleKeys.ChooseDepartment,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .highlightColor,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w800),
                                      ).tr(),
                                    )
                                  : Text(
                                      dropval,
                                      style: TextStyle(
                                          color:
                                              Theme.of(context).highlightColor,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800),
                                    ),
                              onChanged: (newVal) {
                                dropval = newVal;
                                this.setState(() {});
                              }),
                        ),
                      ),
                      // Container(
                      //   height: height * 0.3,
                      //   width: width,
                      //   margin: EdgeInsets.all(15),
                      //   decoration: BoxDecoration(
                      //     color: myColor[50],
                      //     borderRadius: BorderRadius.circular(10),
                      //     boxShadow: [
                      //       BoxShadow(
                      //         color: Colors.grey,
                      //         blurRadius: 0.4,
                      //       )
                      //     ],
                      //   ),
                      //   child: Center(
                      //       child: Text(
                      //     'ABC123',
                      //     style: TextStyle(
                      //         color: myColor[100],
                      //         fontSize: 40,
                      //         letterSpacing: 25,
                      //         fontWeight: FontWeight.w800),
                      //   )),
                      // )
                    ],
                  ),
                )
              ],
            ),
          ),
          bottomNavigationBar: onpress
              ? IgnorePointer(
                  child: Container(
                    height: height * 0.06,
                    margin: EdgeInsets.all(15),
                    width: width,
                    decoration: BoxDecoration(
                        color: myColor[150],
                        borderRadius: BorderRadius.circular(10)),
                    child: FlatButton(
                        onPressed: () async {},
                        child: Text(
                          LocaleKeys.GenerateToken,
                          style: TextStyle(color: myColor[100]),
                        ).tr()),
                  ),
                )
              : Container(
                  height: height * 0.06,
                  margin: EdgeInsets.all(15),
                  width: width,
                  decoration: BoxDecoration(
                      color: myColor[50],
                      borderRadius: BorderRadius.circular(10)),
                  child: FlatButton(
                      onPressed: () async {
                        setState(() {
                          onpress = true;
                        });
                        String dateFormat =
                            DateFormat('EEEE','en').format(DateTime.now());
                        String dayy = dateFormat.toLowerCase();
                        var wh = json.decode(widget.wk);
                        print(wh);

                        String workday = wh[dayy]
                            .toString()
                            .replaceAll('{', '')
                            .replaceAll('}', '');
                        print('wk -- $workday');

                        var t = workday.replaceAll('{', '').replaceAll('}', '');
                        var ti = t.split(',');

                        var starttime = ti[0].split(' ')[1];
                        var endtime = ti[1].split(' ')[2];

                        print(ti[0].split(' ')[1] == "null");

                        final currentTime = DateTime.now();
                        // print(currentTime);
                        var date = DateFormat('yyyy-MM-dd', 'en_US');
                        var datetoday = date.format(currentTime);
                        print(datetoday);
                        var year = datetoday.substring(0, 4);
                        var month = datetoday.substring(5, 7);
                        var day = datetoday.substring(8);

                        print('st $starttime');
                        print(endtime);

                        if (starttime == "null" ||
                            endtime == "null" ||
                            starttime == null ||
                            endtime == null) {
                          AppToast.showErr(LocaleKeys.Branchisclosed.tr());
                        } else if (starttime != "null" && endtime != "null" ||
                            starttime != null && endtime != null) {
                          var stH = starttime.substring(0, 2);
                          var stM = starttime.substring(3, 5);

                          var endH = endtime.substring(0, 2);
                          var endM = endtime.substring(3, 5);

                          DateTime start = DateTime(
                              int.parse(year),
                              int.parse(month),
                              int.parse(day),
                              int.parse(stH),
                              int.parse(stM));
                          DateTime end = DateTime(
                              int.parse(year),
                              int.parse(month),
                              int.parse(day),
                              int.parse(endH),
                              int.parse(endM));
                          if (currentTime.isAfter(start) &&
                              currentTime.isBefore(end)) {
                            if (dropval != null) {
                              await Provider.of<SendToken>(context,
                                      listen: false)
                                  .generatetoken(
                                      branchid: widget.bid,
                                      branchname: widget.branchname,
                                      department: dropval,
                                      tokenorbooking: widget.type,
                                      comp: widget.companyname)
                                  .then((value) {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (ctx) => MyHomePage()))
                                    .catchError((e) {
                                  setState(() {
                                    onpress = false;
                                  });
                                });
                              });
                            } else {
                              AppToast.showErr(
                                  LocaleKeys.Pleaseselectdepartment.tr());
                            }
                          } else {
                            AppToast.showErr(LocaleKeys.Branchisclosed.tr());
                          }
                        }

                        // print(start);
                        // if (start != null) {
                        // } else {
                        //   print('g');
                        //   AppToast.showErr('Branch is Closed For Today');
                        // }
                        //else if (start != null && end != null) {
                        // if (currentTime.isAfter(DateTime.parse(start)) &&
                        //     currentTime.isBefore(DateTime.parse(end))) {
                        //     AppToast.showErr('Branch is Closed For Now');
                        //   }
                        // } else if (start != null && end != null) {

                        // }
                      },
                      child: Text(
                        LocaleKeys.GenerateToken,
                        style: TextStyle(color: myColor[100]),
                      ).tr()),
                ),
        );
      },
    );
  }
}
