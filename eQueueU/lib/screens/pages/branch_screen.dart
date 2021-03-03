import 'package:eQueue/components/color.dart';
import 'package:eQueue/screens/pages/book_appointment.dart';
import 'package:eQueue/screens/pages/book_token.dart';
import 'package:flutter/material.dart';

class BranchScreen extends StatefulWidget {
  @override
  _BranchScreenState createState() => _BranchScreenState();
}

class _BranchScreenState extends State<BranchScreen> {
  int sizz;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    if (width <= 320.0) {
      setState(() {
        sizz = 1;
      });
    } else if (height <= 850) {
      setState(() {
        sizz = 2;
      });
    }
    return SafeArea(
      child: Scaffold(
          body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              height: height * 0.05,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: myColor[150],
              ),
              child: Container(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Search Branches',
                      style: TextStyle(
                          color: myColor[250], fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.search,
                      color: myColor[250],
                    )
                  ],
                ),
              ),
            ),
            Flexible(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                height: height * 0.9,
                width: width,
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, i) {
                      return Container(
                        height: height * 0.3,
                        margin: EdgeInsets.all(5),
                        width: width,
                        decoration: BoxDecoration(
                            color: myColor[100],
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(color: Colors.grey)]),
                        child: Column(
                          children: [
                            Flexible(
                              child: Container(
                                height: height * 0.2,
                                width: width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        image: AssetImage(
                                          'lib/assets/imagecomp.jpg',
                                        ),
                                        fit: BoxFit.fill)),
                              ),
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(top: 10, left: 10, right: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: width * 0.4,
                                        child: Text(
                                          'Branch Name',
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: myColor[50],
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.location_history_sharp,
                                              color: myColor[50],
                                            ),
                                            Text('Torronto,Canada')
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.star,
                                              color: myColor[50],
                                            ),
                                            Text('4.4 Ratings')
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                                  Container(
                                    height: height * 0.05,
                                    width: width * 0.4,
                                    decoration: BoxDecoration(
                                        color: myColor[50],
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: FlatButton(
                                        onPressed: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (ctx) => Calen()));
                                        },
                                        child: Text(
                                          'Book Now',
                                          style: TextStyle(color: myColor[100]),
                                        )),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
