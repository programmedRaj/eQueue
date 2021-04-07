import 'package:eQueue/api/models/servicesmodel.dart';
import 'package:eQueue/api/models/working_per_day.dart';
import 'package:eQueue/components/color.dart';
import 'package:eQueue/components/tokenpage.dart';
import 'package:eQueue/provider/department_booking_provider.dart';
import 'package:eQueue/provider/department_token_provider.dart';
import 'package:eQueue/screens/pages/book_appointment.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectService extends StatefulWidget {
  final int id;
  final int bid;
  final String type;
  final List<Working> wk;
  final List<Working> book;
  final List<Working> perday;
  SelectService({
    this.id,
    this.bid,
    this.type,
    this.wk,
    this.book,
    this.perday,
  });
  @override
  _SelectServiceState createState() => _SelectServiceState();
}

class _SelectServiceState extends State<SelectService> {
  String dropval;
  String service;
  String serdes;
  String serrate;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<DepBookProvider>(context, listen: false).getdep(
      bid: widget.bid,
      id: widget.id,
      type: widget.type,
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Consumer<DepBookProvider>(
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
                                  return new DropdownMenuItem<Service>(
                                    value: Service(
                                        service: val.service,
                                        servicedescription:
                                            val.servicedescription,
                                        servicerates: val.servicerates),
                                    child: new Text(
                                        '${val.service} - ${val.servicerates}'),
                                  );
                                }).toList(),
                                hint: dropval == null
                                    ? Container(
                                        width: width * 0.45,
                                        child: Text(
                                          'Choose Service',
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
                                onChanged: (Service newVal) {
                                  dropval =
                                      '${newVal.service} - ${newVal.servicerates}';
                                  this.setState(() {
                                    service = newVal.service;
                                    serrate = newVal.servicerates;
                                    serdes = newVal.servicedescription;
                                  });
                                }),
                          ),
                        ),
                        Container(
                            height: height * 0.3,
                            width: width,
                            margin: EdgeInsets.all(15),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: myColor[50],
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 0.4,
                                )
                              ],
                            ),
                            child: ListView(
                              children: [
                                serdes != null
                                    ? Text('Service Description : ${serdes}')
                                    : Text('No Description'),
                              ],
                            ))
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
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => Calen(
                              book: widget.book,
                              perday: widget.perday,
                              wk: widget.wk,
                            )));
                  },
                  child: Text(
                    'Schedule Time',
                    style: TextStyle(color: myColor[100]),
                  )),
            ));
      },
    );
  }
}
