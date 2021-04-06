import 'package:equeuebiz/constants/appcolor.dart';
import 'package:equeuebiz/constants/textstyle.dart';
import 'package:flutter/material.dart';

class Bookings extends StatefulWidget {
  @override
  _BookingsState createState() => _BookingsState();
}

class _BookingsState extends State<Bookings> {
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Bookings",
          style: TextStyle(color: Colors.black),
        ),
        actions: [_dateFilter()],
      ),
      body: Container(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1200),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [_tokenCard()],
              ),
            ),
          )),
    );
  }

  Widget _dateFilter() {
    return InkWell(
      onTap: () {
        showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 30)))
            .then((value) {
          if (value != null) {
            setState(() {
              _selectedDate = value;
            });
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.mainBlue),
            borderRadius: BorderRadius.circular(4)),
        alignment: Alignment.center,
        child: Row(
          children: [
            Text(
              "${_selectedDate.day} / ${_selectedDate.month}",
              style: TextStyle(color: Colors.black),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }

  Widget _tokenCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 3)]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Booking Number",
                style: blackBoldFS16,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text("booking details desc  s SD<C S<JD JC S<JDBC<JSB<JC "),
            Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: AppColor.mainBlue)),
                  child: Text(
                    "2:30 - 3:00",
                    style: TextStyle(
                        color: AppColor.mainBlue, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: AppColor.mainBlue)),
                  child: Text(
                    "Dept",
                    style: TextStyle(
                        color: AppColor.mainBlue, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Divider(),
            InkWell(
              onTap: () {},
              child: Row(
                children: [
                  Text(
                    "View More",
                    style: TextStyle(
                        color: AppColor.mainBlue, fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColor.mainBlue,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
