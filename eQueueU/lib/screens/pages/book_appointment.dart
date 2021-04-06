import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:eQueue/api/models/working_per_day.dart';
import 'package:eQueue/components/appointmenttime.dart';
import 'package:eQueue/components/color.dart';

class Calen extends StatefulWidget {
  final List<Working> wk;
  final List<Working> book;
  final List<Working> perday;
  const Calen({
    Key key,
    this.wk,
    this.book,
    this.perday,
  }) : super(key: key);
  @override
  _CalenState createState() => _CalenState();
}

class _CalenState extends State<Calen> {
  CalendarController _c = CalendarController();
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
              height: height,
              width: width,
              child: TableCalendar(
                // calendarStyle: CalendarStyle(holidayStyle: ),
                onDaySelected: (day, events, holidays) {
                  String dateFormat = DateFormat('EEEE').format(day);
                  String dayy = dateFormat.toLowerCase();

                  String workday = widget.wk
                      .where((element) => element.day == dayy)
                      .map((e) => e.value)
                      .toString()
                      .replaceAll('(', '')
                      .replaceAll(')', '');
                  print(workday);

                  String bookday = widget.book
                      .where((element) => element.day == dayy)
                      .map((e) => e.value)
                      .toString()
                      .replaceAll('(', '')
                      .replaceAll(')', '');
                  ;
                  print('$bookday');

                  String perday = widget.perday
                      .where((element) => element.day == dayy)
                      .map((e) => e.value)
                      .toString()
                      .replaceAll('(', '')
                      .replaceAll(')', '');
                  ;
                  print(perday);

                  var slots =
                      (int.parse(perday) * 60) / int.parse(bookday).floor();
                  print('----- $slots');
                  setState(() {});

                  List time = workday.split(' - ');

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (ctx) => AppTime(
                            day: day,
                            starttime: time[0],
                            endtime: time[1],
                            slots: slots,
                          )));
                },
                calendarController: _c,
                availableGestures: AvailableGestures.horizontalSwipe,
              ),
            )
          ],
        ),
      ),
    );
  }
}
