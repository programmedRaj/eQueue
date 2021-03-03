import 'package:eQueue/components/color.dart';
import 'package:flutter/material.dart';

class AppTime extends StatefulWidget {
  DateTime day;
  AppTime({this.day});
  @override
  _AppTimeState createState() => _AppTimeState();
}

class _AppTimeState extends State<AppTime> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.day.toString().substring(0, 11)),
      ),
      body: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, i) {
            return Container(
              height: height * 0.3,
              width: width,
              margin: EdgeInsets.all(5),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text('Number Of Slots Available'),
                  ),
                  Container(
                    height: height * 0.2,
                    child: GridView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 20,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemBuilder: (context, i) {
                          return Container(
                            height: height * 0.1,
                            width: width * 0.25,
                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: myColor[100],
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: myColor[50]),
                            ),
                            child: Center(child: Text('08:00 AM')),
                          );
                        }),
                  )
                ],
              ),
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
