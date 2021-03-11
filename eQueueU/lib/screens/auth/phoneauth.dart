import 'package:eQueue/components/color.dart';
import 'package:eQueue/screens/auth/verification.dart';
import 'package:flutter/material.dart';

class Phone extends StatefulWidget {
  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              height: height * 0.4,
              width: width,
              margin: EdgeInsets.all(20),
              child: Image.asset(
                'lib/assets/line.png',
                fit: BoxFit.fill,
              )),
          Container(
            width: width,
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: myColor[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              keyboardType: TextInputType.phone,
              decoration: new InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: myColor[50], width: 2.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: myColor[250], width: 2.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.red, width: 2.0),
                  ),
                  disabledBorder: InputBorder.none,
                  contentPadding:
                      EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                  hintText: "Mobile Number",
                  hintStyle: TextStyle(color: myColor[250])),
            ),
          ),
          Container(
            height: height * 0.06,
            width: width,
            margin: EdgeInsets.only(top: 10, left: 20, right: 20),
            decoration: BoxDecoration(
              color: myColor[50],
              borderRadius: BorderRadius.circular(10),
            ),
            child: FlatButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Verification(),
                    ));
              },
              child: Center(
                  child: Text(
                'Get OTP',
                style: TextStyle(
                  color: myColor[100],
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              )),
            ),
          )
        ],
      ),
    );
  }
}
