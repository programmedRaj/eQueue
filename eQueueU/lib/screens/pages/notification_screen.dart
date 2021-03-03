import 'package:eQueue/components/color.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, i) {
            return Container(
              height: height * 0.1,
              width: width,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: myColor[100],
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                  ),
                ],
              ),
              child: ListTile(
                title: Text(
                  'Branch Name',
                  style: TextStyle(
                      color: myColor[250], fontWeight: FontWeight.bold),
                ),
                subtitle: Text('Your Token Number Is Next'),
              ),
            );
          }),
    );
  }
}
