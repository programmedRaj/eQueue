import 'package:equeuebiz/constants/appcolor.dart';
import 'package:equeuebiz/constants/textstyle.dart';
import 'package:equeuebiz/providers/all_multitoken.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MultiTokens extends StatefulWidget {
  final int bid;
  final String token;
  final String bname;
  MultiTokens({this.bid, this.token, this.bname});
  @override
  _MultiTokensState createState() => _MultiTokensState();
}

class _MultiTokensState extends State<MultiTokens> {
  double _currentSliderValue = 0.0;
  int tokenMax;

  @override
  void initState() {
    Provider.of<AllMToken>(context, listen: false)
        .getTokeMndets(widget.bid.toString(), widget.bname, widget.token)
        .then((value) {
      print('$value yy');
      setState(() {
        tokenMax = value;
      });
    });
    super.initState();
  }

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
          "Tokens",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1200),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.38,
                  ),
                  Center(
                    child: tokenMax == 0
                        ? Container(
                            child: Center(
                              child: Text("No Tokens"),
                            ),
                          )
                        : Slider(
                            value: _currentSliderValue,
                            min: 0,
                            max: double.parse(tokenMax.toString()), //idr var,.
                            divisions: 10,
                            label: _currentSliderValue.round().toString(),
                            activeColor: Colors.green,
                            onChanged: (double value) {
                              setState(() {
                                _currentSliderValue = value;
                              });
                            },
                          ),
                  ),
                  Spacer(),
                  Align(alignment: Alignment.bottomCenter, child: _callButton())
                ],
              ),
            ),
          )),
    );
  }

  Widget _callButton() {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: tokenMax == 0
          ? Container()
          : Container(
              //width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                  color: AppColor.mainBlue,
                  borderRadius: BorderRadius.circular(4)),
              alignment: Alignment.center,
              child: Text(
                "CALL",
                style: TextStyle(color: Colors.white),
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
                "Token Number",
                style: blackBoldFS16,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            //Text("Token desc  s SD<C S<JD JC S<JDBC<JSB<JC "),
            Divider(),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border.all(color: AppColor.mainBlue)),
              child: Text(
                "Department : Ban",
                style: TextStyle(
                    color: AppColor.mainBlue, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 8,
            ),
          ],
        ),
      ),
    );
  }
}
