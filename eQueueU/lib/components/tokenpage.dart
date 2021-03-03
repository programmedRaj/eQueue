import 'package:eQueue/components/color.dart';
import 'package:flutter/material.dart';

class TokenPage extends StatefulWidget {
  @override
  _TokenPageState createState() => _TokenPageState();
}

class _TokenPageState extends State<TokenPage> {
  List depa = ['j', 'k', 'l'];
  String dropval;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          width: width,
          margin: EdgeInsets.all(20),
          decoration: BoxDecoration(
              border:
                  Border.all(color: Theme.of(context).accentColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.all(10),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
                items: depa.map((val) {
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
                              color: Theme.of(context).highlightColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w800),
                        ),
                      )
                    : Text(
                        dropval,
                        style: TextStyle(
                            color: Theme.of(context).highlightColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w800),
                      ),
                onChanged: (newVal) {
                  dropval = newVal;
                  this.setState(() {});
                }),
          ),
        ),
        Container(
          height: height * 0.3,
          width: width,
          margin: EdgeInsets.all(15),
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
          child: Center(
              child: Text(
            'ABC123',
            style: TextStyle(
                color: myColor[100],
                fontSize: 40,
                letterSpacing: 25,
                fontWeight: FontWeight.w800),
          )),
        )
      ],
    );
  }
}
