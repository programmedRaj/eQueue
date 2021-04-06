import 'package:eQueue/components/color.dart';
import 'package:flutter/material.dart';

class AppTime extends StatefulWidget {
  final DateTime day;
  final double slots;
  final String starttime;
  final String endtime;
  AppTime({this.day, this.slots, this.starttime, this.endtime});
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
  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.day.toString().substring(0, 11)),
      ),
      body: GridView.builder(
          // scrollDirection: Axis.horizontal,
          itemCount: times.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, childAspectRatio: 1 / 0.55),
          itemBuilder: (context, i) {
            return Container(
              height: height * 0.1,
              width: width * 0.25,
              margin: EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
              decoration: BoxDecoration(
                color: myColor[100],
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: myColor[50]),
              ),
              child: Center(child: Text(times[i])),
            );
          }),
      backgroundColor: myColor[100],
      bottomNavigationBar: Container(
        height: height * 0.06,
        width: width,
        decoration: BoxDecoration(color: myColor[50]),
        child: FlatButton(
          onPressed: () {},
          child: Text(
            'Book Now',
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
