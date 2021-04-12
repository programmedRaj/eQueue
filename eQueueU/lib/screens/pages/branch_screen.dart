import 'package:eQueue/api/models/branchmodel.dart';
import 'package:eQueue/components/color.dart';
import 'package:eQueue/constants/appcolor.dart';
import 'package:eQueue/provider/branch_provider.dart';
import 'package:eQueue/provider/company_provider.dart';
import 'package:eQueue/provider/token_check_provider.dart';
import 'package:eQueue/screens/pages/book_appoint_service.dart';
import 'package:eQueue/screens/pages/book_appointment.dart';
import 'package:eQueue/screens/pages/book_token.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:provider/provider.dart';

class BranchScreen extends StatefulWidget {
  final int id;
  final String comp_type;

  BranchScreen({this.id, this.comp_type});
  @override
  _BranchScreenState createState() => _BranchScreenState();
}

class _BranchScreenState extends State<BranchScreen> {
  int sizz;
  String searchval = "";
  List<BranchModel> branchsearch = [];
  String noprod;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<BranchProvider>(context, listen: false)
        .getBranches(id: widget.id, sort: false);
  }

  @override
  Widget build(BuildContext context) {
    print(widget.comp_type);
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
    onsearch(v, List<BranchModel> branch) {
      v = v.toString().toUpperCase();
      print(v);
      if (v != null) {
        branchsearch.clear();
        for (int i = 0; i < branch.length; i++) {
          if (branch[i].bname.toLowerCase().contains(v) ||
              branch[i].bname.toUpperCase().contains(v) ||
              branch[i].bname.contains(v)) {
          } else {
            setState(() {
              noprod = 'No branch';
            });
          }
        }
      }
    }

    return Consumer<BranchProvider>(
      builder: (context, value, child) {
        print(value.branches.length);
        return SafeArea(
          child: Scaffold(
              body: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: height * 0.07,
                      width: width / 1.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: myColor[150],
                      ),
                      child: Container(
                          padding: EdgeInsets.all(10),
                          child: TextFormField(
                            onChanged: (val) {
                              onsearch(val, value.branches);

                              if (val.length == 0) {
                                branchsearch.clear();
                              }
                            },
                            cursorColor: Colors.white,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: 'Search Branches',
                                suffixIcon: Icon(Icons.search)),
                          )),
                    ),
                    SizedBox(
                      width: width * 0.02,
                    ),
                    Container(
                      child: IconButton(
                          onPressed: () {
                            sortAlert();
                          },
                          icon: Icon(
                            Icons.sort,
                            color: myColor[250],
                          )),
                    )
                  ],
                ),
                value.branches.length == 0 || value.branches.isEmpty
                    ? Container(
                        margin: EdgeInsets.only(top: height / 2.5),
                        child: Center(
                          child: Text(
                            'No Branches',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: AppColor.mainBlue),
                          ),
                        ),
                      )
                    : Flexible(
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          height: height * 0.9,
                          width: width,
                          child: ListView.builder(
                              itemCount: value.branches.length,
                              itemBuilder: (context, i) {
                                return Container(
                                  height: height * 0.3,
                                  margin: EdgeInsets.all(5),
                                  width: width,
                                  decoration: BoxDecoration(
                                      color: myColor[100],
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(color: Colors.grey)
                                      ]),
                                  child: Column(
                                    children: [
                                      Flexible(
                                        child: Container(
                                          height: height * 0.2,
                                          width: width,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                    'lib/assets/imagecomp.jpg',
                                                  ),
                                                  fit: BoxFit.fill)),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 10, left: 10, right: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Flexible(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    width: width * 0.4,
                                                    child: Text(
                                                      value.branches[i].bname,
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                          color: myColor[50],
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        top: height * 0.01),
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .location_history_sharp,
                                                          color: myColor[50],
                                                        ),
                                                        Text(value
                                                            .branches[i].city)
                                                      ],
                                                    ),
                                                  ),
                                                  // Container(
                                                  //   child: Row(
                                                  //     children: [
                                                  //       Icon(
                                                  //         Icons.star,
                                                  //         color: myColor[50],
                                                  //       ),
                                                  //       Text('4.4 Ratings')
                                                  //     ],
                                                  //   ),
                                                  // )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              height: height * 0.05,
                                              width: width * 0.4,
                                              decoration: BoxDecoration(
                                                  color: myColor[50],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: FlatButton(
                                                  onPressed: () {
                                                    Provider.of<TokenChecker>(
                                                            context,
                                                            listen: false)
                                                        .checkToken(
                                                            branchid: value
                                                                .branches[i].id,
                                                            tokenorbooking:
                                                                widget
                                                                    .comp_type,
                                                            branchname: value
                                                                .branches[i]
                                                                .bname);
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (ctx) => widget
                                                                        .comp_type ==
                                                                    "booking"
                                                                ? SelectService(
                                                                    bid: value
                                                                        .branches[
                                                                            i]
                                                                        .id,
                                                                    id: value
                                                                        .branches[
                                                                            i]
                                                                        .companyid,
                                                                    type: widget
                                                                        .comp_type,
                                                                    book: value
                                                                        .bookingsperhrs,
                                                                    perday: value
                                                                        .perdayhrss,
                                                                    wk: value
                                                                        .workinghrsper,
                                                                  )
                                                                : Booktoken(
                                                                    branchname: value
                                                                        .branches[
                                                                            i]
                                                                        .bname,
                                                                    bid: value
                                                                        .branches[
                                                                            i]
                                                                        .id,
                                                                    id: value
                                                                        .branches[
                                                                            i]
                                                                        .companyid,
                                                                    type: widget
                                                                        .comp_type)));
                                                  },
                                                  child: Text(
                                                    'Book Now',
                                                    style: TextStyle(
                                                        color: myColor[100]),
                                                  )),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ),
                      ),
              ],
            ),
          )),
        );
      },
    );
  }

  sortAlert() {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return MyD(widget.id);
      },
    );
  }
}

class MyD extends StatefulWidget {
  int id;
  MyD(this.id);
  @override
  _MyDState createState() => _MyDState();
}

class _MyDState extends State<MyD> {
  var _picked = "Bname";
  var _order = "ASC";
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return AlertDialog(
      content: Container(
        height: height * 0.45,
        width: width,
        child: Column(
          children: [
            Container(alignment: Alignment.centerLeft, child: Text('Sort By')),
            RadioButtonGroup(
              orientation: GroupedButtonsOrientation.HORIZONTAL,
              margin: const EdgeInsets.only(left: 12.0),
              onSelected: (String selected) => setState(() {
                _picked = selected;
                print(selected);
              }),
              labels: <String>[
                "Bname",
                "City",
              ],
              picked: _picked,
              itemBuilder: (Radio rb, Text txt, int i) {
                return Column(
                  children: <Widget>[
                    Icon(Icons.public),
                    rb,
                    txt,
                  ],
                );
              },
            ),
            SizedBox(
              height: height * 0.04,
            ),
            Container(
                alignment: Alignment.centerLeft, child: Text('Sort Order')),
            RadioButtonGroup(
              orientation: GroupedButtonsOrientation.HORIZONTAL,
              margin: const EdgeInsets.only(left: 12.0),
              onSelected: (String selected) => setState(() {
                _order = selected;
              }),
              labels: <String>[
                "ASC",
                "DESC",
              ],
              picked: _order,
              itemBuilder: (Radio rb, Text txt, int i) {
                return Column(
                  children: <Widget>[
                    Icon(Icons.public),
                    rb,
                    txt,
                  ],
                );
              },
            ),
            Container(
              alignment: Alignment.centerRight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: height * 0.06,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Provider.of<BranchProvider>(context, listen: false)
                            .getBranches(
                                id: widget.id,
                                sort: true,
                                ascdsc: _order,
                                sortby: _picked.toLowerCase(),
                                type: 'branch')
                            .then((value) => Navigator.of(context).pop());
                      },
                      child: Text('Ok')),
                  SizedBox(
                    width: width * 0.02,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('Cancel'))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
