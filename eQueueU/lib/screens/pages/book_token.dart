import 'package:eQueue/components/color.dart';
import 'package:eQueue/components/tokenpage.dart';
import 'package:eQueue/constants/apptoast.dart';
import 'package:eQueue/provider/department_token_provider.dart';
import 'package:eQueue/provider/send_token.dart';
import 'package:eQueue/provider/token_check_provider.dart';
import 'package:eQueue/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Booktoken extends StatefulWidget {
  final int id;
  final int bid;
  final String type;
  final String branchname;
  Booktoken({this.id, this.bid, this.type, this.branchname});
  @override
  _BooktokenState createState() => _BooktokenState();
}

class _BooktokenState extends State<Booktoken> {
  String dropval;

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
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
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
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
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
                    child: Column(
                      children: [
                        Container(
                          width: width,
                          margin: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).accentColor,
                                  width: 1),
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
                                          'Choose Department',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .highlightColor,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      )
                                    : Text(
                                        dropval,
                                        style: TextStyle(
                                            color: Theme.of(context)
                                                .highlightColor,
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
            bottomNavigationBar: Container(
              height: height * 0.06,
              margin: EdgeInsets.all(15),
              width: width,
              decoration: BoxDecoration(
                  color: myColor[50], borderRadius: BorderRadius.circular(10)),
              child: FlatButton(
                  onPressed: () async {
                    if (dropval != null) {
                      await Provider.of<SendToken>(context, listen: false)
                          .generatetoken(
                              branchid: widget.bid,
                              branchname: widget.branchname,
                              department: dropval,
                              tokenorbooking: widget.type)
                          .then((value) {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (ctx) => MyHomePage()));
                      });
                    } else {
                      AppToast.showErr('Please select department');
                    }
                  },
                  child: Text(
                    'Generate Token',
                    style: TextStyle(color: myColor[100]),
                  )),
            ));
      },
    );
  }
}
