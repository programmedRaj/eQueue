import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:eQueue/api/models/working_per_day.dart';
import 'package:eQueue/components/appointmenttime.dart';
import 'package:eQueue/components/color.dart';
import 'package:eQueue/constants/apptoast.dart';

class Calen extends StatefulWidget {
  final String wk;
  final String book;
  final String perday;
  final String companyname;
  final String branchname;
  final int branchid;
  final String servicename;
  final String servicerate;
  final String servicedess;
  final String type;
  const Calen({
    this.type,
    this.wk,
    this.book,
    this.perday,
    this.companyname,
    this.branchname,
    this.branchid,
    this.servicename,
    this.servicerate,
    this.servicedess,
  });

  @override
  _CalenState createState() => _CalenState();
}

class _CalenState extends State<Calen> {
  CalendarController _c = CalendarController();
  List<Working> wk = [];
  int whichday;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    var wh = json.decode(widget.wk);
    var book = json.decode(widget.book);
    var perdayy = json.decode(widget.perday);

    print(book);

    return Scaffold(
      appBar: AppBar(
        title: Text('Time Slot'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: height,
              width: width,
              child: TableCalendar(
                // calendarStyle: CalendarStyle(holidayStyle: ),
                onDaySelected: (day, events, holidays) {
                  String dateFormat = DateFormat('EEEE').format(day);
                  String dayy = dateFormat.toLowerCase();
                  print(dayy);

                  if (dayy == 'monday') {
                    setState(() {
                      whichday = 0;
                    });
                  } else if (dayy == 'tuesday') {
                    setState(() {
                      whichday = 1;
                    });
                  } else if (dayy == 'wednesday') {
                    setState(() {
                      whichday = 2;
                    });
                  } else if (dayy == 'thursday') {
                    setState(() {
                      whichday = 3;
                    });
                  } else if (dayy == 'friday') {
                    setState(() {
                      whichday = 4;
                    });
                  } else if (dayy == 'saturday') {
                    setState(() {
                      whichday = 5;
                    });
                  } else if (dayy == 'sunday') {
                    setState(() {
                      whichday = 6;
                    });
                  }

                  String workday = wh[dayy]
                      .toString()
                      .replaceAll('{', '')
                      .replaceAll('}', '');
                  print('wk -- $workday');

                  String bookday = book[whichday];
                  // .toString()
                  // .replaceAll('{', '')
                  // .replaceAll('}', '');

                  print('book -- $bookday');

                  String perday = perdayy[whichday];
                  // .where((element) => element.day == dayy)
                  // .map((e) => e.value)
                  // .first
                  // .toString()
                  // .replaceAll('(', '')
                  // .replaceAll(')', '');

                  print('pr --- $perday');
                  print(perday.length);
                  if (perday.length > 0 && bookday.length > 0 ||
                      perday.isNotEmpty && bookday.isNotEmpty) {
                    print('open');
                    var slot = (int.parse(perday) * 60) / int.parse(bookday);
                    var slots = slot.floor();
                    print('----- $slots');
                    setState(() {});

                    var t = workday.replaceAll('{', '').replaceAll('}', '');
                    var ti = t.split(',');
                    var end = ti[0].split(' ')[1];
                    var start = ti[1].split(' ')[2];

                    print('$start --- $end');

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => AppTime(
                              day: day,
                              starttime: start,
                              endtime: end,
                              slots: slots,
                              branchid: widget.branchid,
                              branchname: widget.branchname,
                              companyname: widget.companyname,
                              servicedess: widget.servicedess,
                              servicename: widget.servicename,
                              servicerate: widget.servicerate,
                              type: widget.type,
                            )));
                  } else {
                    AppToast.showErr('Branch is closed');
                  }
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
