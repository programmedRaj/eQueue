import 'package:equeuebiz/constants/appcolor.dart';
import 'package:equeuebiz/constants/textstyle.dart';
import 'package:equeuebiz/model/employee_model.dart';
import 'package:equeuebiz/providers/auth_prov.dart';
import 'package:equeuebiz/providers/branches_data_prov.dart';
import 'package:equeuebiz/providers/emp_data_provider.dart';
import 'package:equeuebiz/screens/create_employee.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class Employees extends StatefulWidget {
  @override
  _EmployeesState createState() => _EmployeesState();
}

class _EmployeesState extends State<Employees> {
  String _chosenBranch;
  Map<int, String> branchesList = {};
  AuthProv authProv;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<BranchDataProv>(context, listen: false)
          .getBranches(context, authProv.authinfo.jwtToken);
    });
  }

  @override
  Widget build(BuildContext context) {
    authProv = Provider.of<AuthProv>(context);
    return Consumer<BranchDataProv>(
      builder: (context, bdp, child) {
        branchesList = bdp.branches;

        if (_chosenBranch == null) {
          var temp = bdp.branches.values.toList();
          _chosenBranch = temp[0];
        }
        /* if (_chosenBranch != null && !bdp.isLoading) {
          var temp = bdp.branches.keys.toList();
          _chosenBranch = temp[0];
          Provider.of<EmpDataProv>(context, listen: false)
              .getEmployeesWithDetailAcctoBranch(
                  authProv.authinfo.jwtToken, branchesList[_chosenBranch]);
        } */
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
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 1200),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _createEmployeeCard(),
                      bdp.isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : bdp.noBranches
                              ? Center(
                                  child: Text(
                                      "No branches & employees to display"),
                                )
                              : bdp.error
                                  ? Center(
                                      child: Text("Something went wrong"),
                                    )
                                  : Consumer<EmpDataProv>(
                                      builder: (context, edp, child) {
                                        return Column(
                                          children: [
                                            _selectBranch(),
                                            for (var i = 0;
                                                i <
                                                    edp?.employeesWithDetail
                                                        ?.length;
                                                i++)
                                              _employeeCard(
                                                  edp.employeesWithDetail[i])
                                          ],
                                        );
                                      },
                                    )
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
      },
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

  Widget _selectBranch() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          border: Border.all(color: AppColor.mainBlue),
          borderRadius: BorderRadius.circular(4)),
      child: DropdownButton<String>(
        underline: SizedBox(),
        isExpanded: true,
        focusColor: Colors.white,
        value: _chosenBranch,
        //elevation: 5,
        style: TextStyle(color: Colors.white),
        iconEnabledColor: Colors.black,
        items:
            branchesList.values.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(color: Colors.black),
            ),
          );
        }).toList(),
        hint: Text(
          "Select a Branch",
          style: TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
        ),
        onChanged: (String val) {
          int _branchId;
          branchesList.forEach((key, value) {
            if (val == value) {
              _branchId = key;
            }
          });
          Provider.of<EmpDataProv>(context, listen: false)
              .getEmployeesWithDetailAcctoBranch(
                  authProv.authinfo.jwtToken, _branchId);
          setState(() {
            _chosenBranch = val;
          });
        },
      ),
    );
  }

  Widget _employeeCard(EmployeeModel empdets) {
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
              "${empdets.name}",
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
                InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CreateEmployee(
                              empDets: empdets,
                            ),
                          ));
                    },
                    child: Icon(Icons.edit)),
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
