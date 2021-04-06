import 'package:equeuebiz/constants/appcolor.dart';
import 'package:equeuebiz/constants/textstyle.dart';
import 'package:equeuebiz/screens/create_employee.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Employees extends StatefulWidget {
  @override
  _EmployeesState createState() => _EmployeesState();
}

class _EmployeesState extends State<Employees> {
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
          "Employees",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
          alignment: Alignment.center,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1200),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _createEmployeeCard(),
                  _employeeCard(),
                  _employeeCard(),
                  _employeeCard()
                  /* Text("No branches to show ."),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateBranch(),
                          ));
                    },
                    child: Text("Create Branch"),
                    style: ButtonStyle(),
                  ) */
                ],
              ),
            ),
          )),
    );
  }

  Widget _createEmployeeCard() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CreateEmployee(),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: AppColor.mainBlue,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 3)]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Text(
                  "Create Employee",
                  style: TextStyle(color: Colors.white, fontSize: 35),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _employeeCard() {
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
            Text(
              "Employee Name",
              style: blackBoldFS16,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
                "Branch desc  sn FVA Srb jfr h,j j fj<JF,j ,jfjw sfjs fjawe,jf jwe fje wfjw fjbfbr,rfb smdfvsdhcbSEBDF<cbs,edc,E<DJCb,jSBDC< SD<C S<JD JC S<JDBC<JSB<JC "),
            Divider(),
            Text(
              "Something -- Someting",
              style: TextStyle(color: AppColor.mainBlue),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              children: [
                _ratingStar(),
                Spacer(),
                Icon(Icons.edit),
                SizedBox(width: 20),
                Icon(Icons.delete)
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _ratingStar() {
    return SmoothStarRating(
        allowHalfRating: false,
        onRated: (v) {},
        starCount: 5,
        rating: 4.5,
        size: 30.0,
        isReadOnly: true,
        filledIconData: Icons.star,
        halfFilledIconData: Icons.star_half,
        color: Colors.yellow,
        borderColor: Colors.green,
        spacing: 0.0);
  }
}
