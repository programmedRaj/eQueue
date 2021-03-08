import 'package:equeuebiz/constants/appcolor.dart';
import 'package:equeuebiz/constants/textstyle.dart';
import 'package:equeuebiz/screens/create_branch.dart';
import 'package:flutter/material.dart';

class Tokens extends StatefulWidget {
  @override
  _TokensState createState() => _TokensState();
}

class _TokensState extends State<Tokens> {
  List<String> tokenStatusList = ["on Wait", "Call", "Cancel"];
  String tokenStatus = "on Wait";
  List<String> departmentsList = [
    "Department 1",
    "Department 2",
    "Department 3"
  ];
  String selectedDept = "Department 1";
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
        actions: [_departmentFilter()],
      ),
      body: Container(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1200),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [_tokenCard()],
              ),
            ),
          )),
    );
  }

  Widget _departmentFilter() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          border: Border.all(color: AppColor.mainBlue),
          borderRadius: BorderRadius.circular(4)),
      child: DropdownButton<String>(
        underline: SizedBox(),
        isExpanded: false,
        focusColor: Colors.white,
        value: selectedDept,
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
          "Select",
          style: TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
        ),
        onChanged: (String value) {
          setState(() {
            selectedDept = value;
          });
        },
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
            Container(
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
                value: tokenStatus,
                //elevation: 5,
                style: TextStyle(color: Colors.white),
                iconEnabledColor: Colors.black,
                items: tokenStatusList
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
                hint: Text(
                  "Select a status",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500),
                ),
                onChanged: (String value) {
                  setState(() {
                    tokenStatus = value;
                  });
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  OptionsDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            dialogOptElement("on Wait"),
            Divider(
              thickness: 1,
              color: Colors.black.withOpacity(0.2),
            ),
            dialogOptElement("call"),
            Divider(
              thickness: 1,
              color: Colors.black.withOpacity(0.2),
            ),
            dialogOptElement("cancel")
          ],
        ),
      ),
    );
  }

  Widget dialogOptElement(String text) {
    return InkWell(
      onTap: () {
        setState(() {
          tokenStatus = text;
        });
        Navigator.pop(context);
      },
      child: Text(text),
    );
  }
}
