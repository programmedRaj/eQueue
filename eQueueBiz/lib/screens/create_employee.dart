import 'package:equeuebiz/constants/appcolor.dart';
import 'package:equeuebiz/constants/textstyle.dart';
import 'package:equeuebiz/widgets/appbar.dart';
import 'package:equeuebiz/widgets/custom_widgets.dart';
import 'package:equeuebiz/widgets/resize_helper.dart';
import 'package:flutter/material.dart';

class CreateEmployee extends StatefulWidget {
  @override
  _CreateEmployeeState createState() => _CreateEmployeeState();
}

class _CreateEmployeeState extends State<CreateEmployee> {
  List<String> branchesList = ["Branch 1", " Branch 2", "Branch 3"];
  List<String> departmentsList = [
    "Department 1",
    "Department 2",
    "Department 3"
  ];
  TextEditingController _departmentController = TextEditingController();
  String _chosenDept;
  String _chosenBranch;
  bool employeeStatus = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: whiteAppBar(context, "Create Employee"),
        body: Container(
            alignment: Alignment.topCenter,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 1200),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _selectBranch(),
                    _textField("Name"),
                    _textField("Email ID"),
                    _textField("Password"),
                    Container(
                      height: 50,
                      child: Row(
                        children: [
                          Flexible(
                            child: Container(
                                width: size.width * 0.5,
                                child: _textField("Counter")),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text("Status"),
                          Switch(
                              value: employeeStatus,
                              onChanged: (val) {
                                setState(() {
                                  employeeStatus = val;
                                });
                              })
                        ],
                      ),
                    ),
                    _selectDepartment(),
                    SizedBox(
                      height: 20,
                    ),
                    addCancel()
                  ],
                ),
              ),
            )),
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
        items: branchesList.map<DropdownMenuItem<String>>((String value) {
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
        onChanged: (String value) {
          setState(() {
            _chosenBranch = value;
          });
        },
      ),
    );
  }

  Widget _selectDepartment() {
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
        value: _chosenDept,
        //elevation: 5,
        style: TextStyle(color: Colors.white),
        iconEnabledColor: Colors.black,
        items: departmentsList.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: TextStyle(color: Colors.black),
            ),
          );
        }).toList(),
        hint: Text(
          "Select a Department",
          style: TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
        ),
        onChanged: (String value) {
          setState(() {
            _chosenDept = value;
          });
        },
      ),
    );
  }

  Widget _textField(String hintText) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(4)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget addCancel() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      height: 50,
      child: Row(
        children: [
          Expanded(child: CustomWidgets().filledButton("ADD")),
          SizedBox(
            width: 25,
          ),
          Expanded(child: CustomWidgets().hollowButton("CANCEL"))
        ],
      ),
    );
  }
}
