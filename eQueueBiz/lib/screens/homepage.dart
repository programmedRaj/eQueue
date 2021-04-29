import 'package:equeuebiz/constants/appcolor.dart';
import 'package:equeuebiz/constants/textstyle.dart';
import 'package:equeuebiz/enum/company_enum.dart';
import 'package:equeuebiz/enum/user_type.dart';
import 'package:equeuebiz/locale/app_localization.dart';
import 'package:equeuebiz/model/bizdetsmo.dart';
import 'package:equeuebiz/providers/auth_prov.dart';
import 'package:equeuebiz/providers/biz_details.dart';
import 'package:equeuebiz/providers/booking_prov.dart';
import 'package:equeuebiz/providers/emp_branchdets.dart';
import 'package:equeuebiz/screens/bookings.dart';
import 'package:equeuebiz/screens/branches.dart';
import 'package:equeuebiz/screens/employees.dart';
import 'package:equeuebiz/screens/multi_tokens.dart';
import 'package:equeuebiz/screens/privacypolicy.dart';
import 'package:equeuebiz/screens/profile.dart';
import 'package:equeuebiz/screens/settings.dart';
import 'package:equeuebiz/screens/tnc.dart';
import 'package:equeuebiz/screens/tokens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.get('email');
    var password = prefs.get('pass');

    Provider.of<AuthProv>(context, listen: false)
        .execLogin(email, password)
        .then((value) {
      Provider.of<BizUserDets>(context, listen: false).getBizUserdets();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BizUserDets>(
      builder: (context, bizdets, child) {
        return Consumer<AuthProv>(
          builder: (context, authProv, child) {
            print("${authProv.authinfo?.companyType}");
            Provider.of<BookingBranDet>(context)
                .getbookdets(authProv.authinfo?.jwtToken);
            return authProv.authinfo?.userType == null
                ? Container(
                    color: Colors.white,
                    child: Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(AppColor.mainBlue),
                      ),
                    ),
                  )
                : Scaffold(
                    /* appBar: AppBar(
            title: Text("Home"),
            actions: [IconButton(icon: Icon(Icons.logout), onPressed: () {})],
          ), */
                    body: Consumer<BookingBranDet>(
                      builder: (context, value, child) {
                        return SafeArea(
                          child: Container(
                              alignment: Alignment.center,
                              child: ConstrainedBox(
                                constraints: BoxConstraints(maxWidth: 1200),
                                child: Column(
                                  children: [
                                    _profileWidget(authProv, bizdets.ss),
                                    _branchEmployee(),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            authProv.authinfo.userType ==
                                                    UserEnum.Company
                                                ? InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    Branches(),
                                                          ));
                                                    },
                                                    child: _cards("Branches",
                                                        "Edit/Manage branches details"))
                                                : SizedBox(),
                                            authProv.authinfo.userType ==
                                                    UserEnum.Employee
                                                ? authProv.authinfo
                                                                .companyType ==
                                                            CompanyEnum.Token ||
                                                        authProv.authinfo
                                                                .companyType ==
                                                            CompanyEnum
                                                                .MultiToken
                                                    ? InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          Tokens()));
                                                        },
                                                        child: _cards(
                                                            "Bookings",
                                                            "Edit/Manage Booking details"))
                                                    : SizedBox()
                                                : SizedBox(),
                                            authProv.authinfo.userType ==
                                                    UserEnum.Employee
                                                ? authProv.authinfo
                                                            .companyType ==
                                                        CompanyEnum.Booking
                                                    ? InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        Bookings(
                                                                  branchid:
                                                                      value.bid,
                                                                  branchname:
                                                                      value
                                                                          .bname,
                                                                  token: authProv
                                                                      .authinfo
                                                                      .jwtToken,
                                                                ),
                                                              ));
                                                        },
                                                        child: _cards(
                                                            "Bookings",
                                                            "Edit/Manage Booking details"))
                                                    : SizedBox()
                                                : SizedBox(),
                                            authProv.authinfo.userType ==
                                                    UserEnum.Company
                                                ? InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (context) =>
                                                                    Employees(),
                                                          ));
                                                    },
                                                    child: _cards("Employee",
                                                        "Edit/Manage employee details"))
                                                : SizedBox(),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (ctx) =>
                                                            Policy()));
                                              },
                                              child: _cards("Privacy & Policy",
                                                  "Click to view"),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (ctx) =>
                                                            TermsCondition()));
                                              },
                                              child: _cards(
                                                  "Terms & Conditions",
                                                  "Click to view"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        );
                      },
                    ),
                  );
          },
        );
      },
    );
  }

  Widget _profileWidget(AuthProv authProv, List<BizDets> b) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 5),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Profile(
                    acn: b[0].acn,
                    acnum: b[0].acnum,
                    bname: b[0].bname,
                    descr: b[0].descr,
                    id: b[0].id,
                    earned: b[0].earned,
                    ifsc: b[0].ifsc,
                    name: b[0].name,
                    moneyearned: b[0].moneyearned,
                    profileurl: b[0].profileurl, //profileurl
                    type: b[0].type,
                  ),
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
                      b.isEmpty ? "" : b[0].name,
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
