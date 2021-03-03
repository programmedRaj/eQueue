import 'package:eQueue/components/color.dart';
import 'package:flutter/material.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
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
                subtitle: Text('Date: 20/02/2021'),
              ),
            );
          }),
    );
  }
}
