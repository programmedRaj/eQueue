import 'dart:io';

import 'package:equeuebiz/constants/appcolor.dart';
import 'package:equeuebiz/constants/textstyle.dart';
import 'package:equeuebiz/providers/auth_prov.dart';
import 'package:equeuebiz/providers/branches_data_prov.dart';
import 'package:equeuebiz/providers/dept_data_prov.dart';
import 'package:equeuebiz/widgets/appbar.dart';
import 'package:equeuebiz/widgets/custom_widgets.dart';
import 'package:equeuebiz/widgets/resize_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class CreateEmployee extends StatefulWidget {
  @override
  _CreateEmployeeState createState() => _CreateEmployeeState();
}

class _CreateEmployeeState extends State<CreateEmployee> {
  Map<String, int> branchesList = {};
  List<String> departmentsList = [];
  TextEditingController _departmentController = TextEditingController();
  String _chosenDept;
  String _chosenBranch;
  bool employeeStatus = true;
  File uploadedImageMob;

  @override
  void initState() {
    super.initState();
    Provider.of<BranchDataProv>(context, listen: false).getBranches(
        Provider.of<AuthProv>(context, listen: false).authinfo.jwtToken);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<BranchDataProv>(
      builder: (context, bdp, child) {
        branchesList = bdp.branches;
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: whiteAppBar(context, "Create Employee"),
            body: bdp.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : bdp.error
                    ? Center(
                        child: Text("Error occured while fetching branches"),
                      )
                    : Container(
                        alignment: Alignment.topCenter,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: 1200),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                _selectBranch(),
                                Consumer<DeptDataProv>(
                                  builder: (context, deptDataprov, child) {
                                    if (!deptDataprov.isLoading &&
                                        _chosenBranch == null) {
                                      return SizedBox();
                                    }
                                    if (deptDataprov.isLoading) {
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    }
                                    if (deptDataprov.error) {
                                      return Center(
                                        child:
                                            Text("Error fetching departments"),
                                      );
                                    }
                                    departmentsList = deptDataprov.deptsList;
                                    return Column(
                                      children: [
                                        uploadedImageMob != null
                                            ? Image.file(
                                                uploadedImageMob,
                                                height: size.height * 0.3,
                                                fit: BoxFit.fill,
                                              )
                                            : SizedBox(),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      AppColor.mainBlue)),
                                          onPressed: () async {
                                            var img = await ImagePicker()
                                                .getImage(
                                                    source:
                                                        ImageSource.gallery);
                                            if (img != null) {
                                              uploadedImageMob = File(img.path);
                                              setState(() {});
                                            }
                                          },
                                          child: Text(
                                            'Upload Image',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
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
                                                    child:
                                                        _textField("Counter")),
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
                                    );
                                  },
                                )
                              ],
                            ),
                          ),
                        )),
          ),
        );
      },
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
        items: branchesList.keys.map<DropdownMenuItem<String>>((String value) {
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
          Provider.of<DeptDataProv>(context, listen: false).getDepts(
              Provider.of<AuthProv>(context, listen: false).authinfo.jwtToken,
              branchesList[_chosenBranch]);
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
          "Select a Department/Service",
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
