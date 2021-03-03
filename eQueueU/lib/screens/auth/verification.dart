import 'package:eQueue/components/color.dart';
import 'package:flutter/material.dart';

class Verification extends StatefulWidget {
  @override
  _VerificationState createState() => _VerificationState();
}

class _VerificationState extends State<Verification> {
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
                  hintText: "OTP",
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
              onPressed: () {},
              child: Center(
                  child: Text(
                'Verify',
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
