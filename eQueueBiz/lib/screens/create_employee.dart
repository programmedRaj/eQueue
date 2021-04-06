import 'dart:io';

import 'package:equeuebiz/constants/appcolor.dart';
import 'package:equeuebiz/constants/textstyle.dart';
import 'package:equeuebiz/enum/company_enum.dart';
import 'package:equeuebiz/model/employee_model.dart';
import 'package:equeuebiz/providers/auth_prov.dart';
import 'package:equeuebiz/providers/branches_data_prov.dart';
import 'package:equeuebiz/providers/create_edit_delete_emp.dart';
import 'package:equeuebiz/providers/dept_data_prov.dart';
import 'package:equeuebiz/screens/homepage.dart';
import 'package:equeuebiz/services/app_toast.dart';
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
  AuthProv authProv;

  TextEditingController _nameC = TextEditingController();
  TextEditingController _emailC = TextEditingController();
  TextEditingController _passwordC = TextEditingController();
  TextEditingController _phoneC = TextEditingController();
  TextEditingController _counterC = TextEditingController();

  @override
  void initState() {
    super.initState();
    Provider.of<BranchDataProv>(context, listen: false).getBranches(
        Provider.of<AuthProv>(context, listen: false).authinfo.jwtToken);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    authProv = Provider.of<AuthProv>(context);
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
                                        _textField("Name", _nameC),
                                        _textField("Email ID", _emailC),
                                        _textField("Password", _passwordC),
                                        _textField("Phone number", _phoneC),
                                        Container(
                                          height: 50,
                                          child: Row(
                                            children: [
                                              Flexible(
                                                child: authProv.authinfo
                                                            .companyType ==
                                                        CompanyEnum.Booking
                                                    ? SizedBox()
                                                    : Container(
                                                        width: size.width * 0.5,
                                                        child: _textField(
                                                            "Counter",
                                                            _counterC)),
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
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 16),
                                          height: 50,
                                          child: Row(
                                            children: [
                                              Expanded(
                                                  child: InkWell(
                                                onTap: () async {
                                                  if (_chosenBranch == null ||
                                                      _chosenDept == null) {
                                                    AppToast.showErr(
                                                        "Choose branch and dept. properly");
                                                  }
                                                  bool success =
                                                      await EmployeeOperationProv()
                                                          .createEmployee(
                                                              authProv.authinfo
                                                                  .jwtToken,
                                                              uploadedImageMob,
                                                              getDetails());

                                                  if (success) {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              HomePage(),
                                                        ));
                                                  }
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 16),
                                                  decoration: BoxDecoration(
                                                      color: AppColor.mainBlue,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4)),
                                                  alignment: Alignment.center,
                                                  child: Text(
                                                    "ADD",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              )),
                                              SizedBox(
                                                width: 25,
                                              ),
                                              Expanded(
                                                  child: CustomWidgets()
                                                      .hollowButton("CANCEL"))
                                            ],
                                          ),
                                        )
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

  Widget _textField(String hintText, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(4)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }

  EmployeeModel getDetails() {
    return EmployeeModel(
        name: _nameC.text,
        email: _emailC.text,
        phoneNo: _phoneC.text,
        password: _passwordC.text,
        counterNumber:
            _counterC.text.length == 0 ? null : num.parse(_counterC.text),
        branchId: branchesList[_chosenBranch],
        req: 'create',
        services: _chosenDept,
        departments: _chosenDept);
  }
}
