import 'package:eQueue/api/models/bookingslot.dart';
import 'package:eQueue/constants/apptoast.dart';
import 'package:eQueue/provider/check_slot.dart';
import 'package:flutter/material.dart';

import 'package:eQueue/components/color.dart';
import 'package:eQueue/screens/pages/payforbooking.dart';
import 'package:provider/provider.dart';

class AppTime extends StatefulWidget {
  final DateTime day;
  final int slots;
  final String starttime;
  final String endtime;
  final String companyname;
  final String branchname;
  final int branchid;
  final String servicename;
  final String servicerate;
  final String servicedess;
  final String type;
  final String i;
  final String compid;
  const AppTime({
    this.compid,
    this.i,
    this.type,
    this.day,
    this.slots,
    this.starttime,
    this.endtime,
    this.companyname,
    this.branchname,
    this.branchid,
    this.servicename,
    this.servicerate,
    this.servicedess,
  });

  @override
  _AppTimeState createState() => _AppTimeState();
}

class _AppTimeState extends State<AppTime> {
  Iterable<TimeOfDay> getTimes(
      TimeOfDay startTime, TimeOfDay endTime, Duration step) sync* {
    var hour = startTime.hour;
    var minute = startTime.minute;

    do {
      yield TimeOfDay(hour: hour, minute: minute);
      minute += step.inMinutes;
      while (minute >= 60) {
        minute -= 60;
        hour++;
      }
    } while (hour < endTime.hour ||
        (hour == endTime.hour && minute <= endTime.minute));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    Provider.of<SlotProvider>(context, listen: false).getslot(
      bid: widget.branchid,
      name: widget.branchname,
      type: widget.type,
    );
  }

  List tlist = [];

  @override
  Widget build(BuildContext context) {
    print('isur ${widget.i}');
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    List starttime = widget.starttime.split(':');
    List endtime = widget.endtime.split(':');

    final startTime = TimeOfDay(
        hour: int.parse(starttime[0]), minute: int.parse(starttime[1]));
    final endTime =
        TimeOfDay(hour: int.parse(endtime[0]), minute: int.parse(endtime[1]));
    final step = Duration(minutes: widget.slots.toInt());

    final times = getTimes(startTime, endTime, step)
        .map((tod) => tod.format(context))
        .toList();
    List<BookingSlot> datet = [];
    return Consumer<SlotProvider>(
      builder: (context, value, child) {
        var datefrommob = widget.day.toString().substring(0, 11);

        if (value.bookings.length != 0) {
          datet = value.booking
              .where((element) =>
                  element.date.replaceAll(new RegExp(r"\s+"), "") ==
                  datefrommob.replaceAll(new RegExp(r"\s+"), ""))
              .toList();

          tlist.clear();
          for (int j = 0; j < times.length; j++) {
            for (int i = 0; i < datet.length; i++) {
              if (datet[i].time.contains(times[j].substring(0, 4))) {
                tlist.add(datet[i].time.substring(0, 4));
              }

              // print(times[i]
              //     .substring(0, 4)
              //     .contains(datet[0].time.substring(0, 4)));
              // print(datet[0].time.substring(0, 4));
            }
          }

          print(tlist);

          //   var t = datet[i].time.contains('PM');
          //   if (t) {
          //     var tt = datet[i].time.toString().split(':')[0];
          //     var ttt = int.parse(tt) + 12;
          //     print(ttt);

          //     String t4 = ttt.toString() +
          //         ':' +
          //         datet[i].time.toString().split(':')[1].substring(0, 2);
          //     tlist.add(t4);
          //   } else if (datet[i].time.contains('AM') &&
          //       datet[i].time.contains('12')) {
          //     tlist.add('00:00');
          //   }
          // }
        }
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.day.toString().substring(0, 11)),
          ),
          body: GridView.builder(
              // scrollDirection: Axis.horizontal,
              itemCount: times.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, childAspectRatio: 1 / 0.5),
              itemBuilder: (context, i) {
                return tlist.contains(times[i].substring(0, 4))
                    ? GestureDetector(
                        onTap: () {
                          AppToast.showErr('Already Booked');
                        },
                        child: Container(
                          height: height * 0.1,
                          width: width * 0.25,
                          margin: EdgeInsets.only(
                              top: 10, bottom: 5, left: 8, right: 8),
                          decoration: BoxDecoration(
                            color: myColor[150],
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: myColor[50]),
                          ),
                          child: Center(
                              child: Text(
                            times[i],
                            style: TextStyle(color: myColor[100]),
                          )),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => PayFor(
                                    time: times[i],
                                    date:
                                        widget.day.toString().substring(0, 11),
                                    branchid: widget.branchid,
                                    branchname: widget.branchname,
                                    companyname: widget.companyname,
                                    servicedess: widget.servicedess,
                                    servicename: widget.servicename,
                                    servicerate: widget.servicerate,
                                    ins: widget.i,
                                    compid: widget.compid,
                                  )));
                        },
                        child: Container(
                          height: height * 0.1,
                          width: width * 0.25,
                          margin: EdgeInsets.only(
                              top: 10, bottom: 5, left: 8, right: 8),
                          decoration: BoxDecoration(
                            color: myColor[100],
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: myColor[50]),
                          ),
                          child: Center(child: Text(times[i])),
                        ),
                      );
              }),
          backgroundColor: myColor[100],
          // bottomNavigationBar: Container(
          //   height: height * 0.06,
          //   width: width,
          //   decoration: BoxDecoration(color: myColor[50]),
          //   child: FlatButton(
          //     onPressed: () {},
          //     child: Text(
          //       'Book Now',
          //       style: TextStyle(
          //         color: myColor[100],
          //         fontWeight: FontWeight.w800,
          //         fontSize: 18,
          //       ),
          //     ),
          //   ),
          // ),
        );
      },
    );
  }
}
