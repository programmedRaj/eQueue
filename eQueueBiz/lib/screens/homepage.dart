import 'package:equeuebiz/constants/appcolor.dart';
import 'package:equeuebiz/constants/textstyle.dart';
import 'package:equeuebiz/enum/company_enum.dart';
import 'package:equeuebiz/enum/user_type.dart';
import 'package:equeuebiz/locale/app_localization.dart';
import 'package:equeuebiz/providers/auth_prov.dart';
import 'package:equeuebiz/screens/bookings.dart';
import 'package:equeuebiz/screens/branches.dart';
import 'package:equeuebiz/screens/employees.dart';
import 'package:equeuebiz/screens/multi_tokens.dart';
import 'package:equeuebiz/screens/profile.dart';
import 'package:equeuebiz/screens/settings.dart';
import 'package:equeuebiz/screens/tokens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var authProv = Provider.of<AuthProv>(context);
    return Scaffold(
      /* appBar: AppBar(
        title: Text("Home"),
        actions: [IconButton(icon: Icon(Icons.logout), onPressed: () {})],
      ), */
      body: SafeArea(
        child: Container(
            alignment: Alignment.center,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1200),
              child: Column(
                children: [
                  _profileWidget(authProv),
                  _branchEmployee(),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          authProv.authinfo.userType == UserEnum.Company
                              ? InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Branches(),
                                        ));
                                  },
                                  child: _cards("Branches",
                                      "Edit/Manage branches details"))
                              : SizedBox(),
                          authProv.authinfo.userType == UserEnum.Company
                              ? InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Employees(),
                                        ));
                                  },
                                  child: _cards("Employee",
                                      "Edit/Manage employee details"))
                              : SizedBox(),
                          authProv.authinfo.companyType == CompanyEnum.Token
                              ? InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Tokens(),
                                        ));
                                  },
                                  child: _cards(
                                      "Token", "Edit/Manage tokens details"))
                              : SizedBox(),
                          authProv.authinfo.companyType ==
                                  CompanyEnum.MultiToken
                              ? InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MultiTokens(),
                                        ));
                                  },
                                  child: _cards("MultiTokens",
                                      "Edit/Manage multiple tokens details"))
                              : SizedBox(),
                          authProv.authinfo.companyType == CompanyEnum.Booking
                              ? InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Bookings(),
                                        ));
                                  },
                                  child: _cards("Bookings",
                                      "Edit/Manage bookings details"))
                              : SizedBox(),
                          _cards("Privacy & Policy", "Click to view"),
                          _cards("Terms & Conditions", "Click to view"),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }

  Widget _profileWidget(AuthProv authProv) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Profile(),
                )),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, color: AppColor.purpleBlue),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  children: [
                    Text(
                      "Denise Rew",
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    Text(userEnumToString(authProv.authinfo.userType))
                  ],
                )
              ],
            ),
          ),
          Spacer(),
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Settings(),
                    )).then((value) {
                  setState(() {});
                });
              })
        ],
      ),
    );
  }

  Widget _branchEmployee() {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.mainBlue,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: AppColor.mainBlue, blurRadius: 3)]),
      padding: const EdgeInsets.all(30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                children: [
                  Text(
                    "0",
                    style: whiteColorBoldFS20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Branches",
                    style: whiteColorBoldFS20,
                  )
                ],
              ),
            ),
          ),
          Container(
            width: 1,
            height: 50,
            color: Colors.white,
          ),
          Expanded(
            flex: 1,
            child: Container(
              child: Column(
                children: [
                  Text(
                    "0",
                    style: whiteColorBoldFS20,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Employees",
                    style: whiteColorBoldFS20,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _cards(String heading, String subHeading) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12),
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 4)]),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.home,
                color: AppColor.mainBlue,
              ),
              Column(
                children: [
                  Text(
                    heading,
                    style: blackBoldFS16,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(subHeading)
                ],
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: AppColor.mainBlue,
              )
            ],
          )),
    );
  }
}
