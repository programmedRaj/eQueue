import 'dart:io';

import 'package:email_validator/email_validator.dart';
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
import 'package:equeuebiz/translations/locale_keys.g.dart';
import 'package:equeuebiz/widgets/appbar.dart';
import 'package:equeuebiz/widgets/custom_widgets.dart';
import 'package:equeuebiz/widgets/resize_helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

class CreateEmployee extends StatefulWidget {
  final EmployeeModel empDets;
  final String images;
  final bool uporadd;
  CreateEmployee({this.empDets, this.images, this.uporadd});
  @override
  _CreateEmployeeState createState() => _CreateEmployeeState();
}

class _CreateEmployeeState extends State<CreateEmployee> {
  Map<int, String> branchesList = {};
  List<String> departmentsList = [];
  TextEditingController _departmentController = TextEditingController();
  String _chosenDept;
  String _chosenBranch;
  bool employeeStatus = true;
  File uploadedImageMob;
  AuthProv authProv;
  File filename;
  bool error = false;
  String imagee;
  String images;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameC = TextEditingController();
  TextEditingController _emailC = TextEditingController();
  TextEditingController _passwordC = TextEditingController();
  TextEditingController _phoneC = TextEditingController();
  TextEditingController _counterC = TextEditingController();
  int couterCount = 1;
  int chosenBranchId;

  @override
  void initState() {
    super.initState();

    Provider.of<BranchDataProv>(context, listen: false)
        .getbranchesWithDetail(
            Provider.of<AuthProv>(context, listen: false).authinfo.jwtToken)
        .then((value) {
      setState(() {
        error = value;
      });
    });

    Provider.of<BranchDataProv>(context, listen: false)
        .getBranches(context,
            Provider.of<AuthProv>(context, listen: false).authinfo.jwtToken)
        .then((value) {
      Provider.of<DeptDataProv>(context, listen: false)
          .getDepts(authProv.authinfo.jwtToken, widget.empDets.branchId)
          .then((depList) {
        departmentsList = depList;
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          setState(() {
            if (value && widget.empDets != null) {
              prefill();
            }
          });
          setState(() {});
        });
      });
    });
  }

  prefill() {
    setState(() {
      images = widget.images;
      imagee = 'https://www.nobatdeh.com/uploads/biz-logos/${widget.images}';
      print('$imagee');
    });
    _nameC.text = widget.empDets.name;
    _emailC.text = widget.empDets.email;
    _passwordC.text = widget.empDets.password;
    _phoneC.text = widget.empDets.phoneNo;
    _counterC.text = widget.empDets.counterNumber?.toString();
    employeeStatus = widget.empDets.empStatus == 0 ? false : true;
    branchesList.forEach((key, value) {
      if (key == widget.empDets.branchId) {
        _chosenBranch = value;
        chosenBranchId = widget.empDets.branchId;
      }
    });
    if (departmentsList.contains(widget.empDets.services) ||
        departmentsList.contains(widget.empDets.departments)) {
      _chosenDept = widget.empDets.departments == null
          ? widget.empDets.services
          : widget.empDets.departments;
    }
    print(widget.empDets.services);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    authProv = Provider.of<AuthProv>(context);

    return Consumer<BranchDataProv>(
      builder: (context, bdp, child) {
        branchesList = bdp.branches;
        if ((true)) {
          bdp.branchesWithDetail?.forEach((element) {
            if (authProv.authinfo.companyType == CompanyEnum.Token ||
                authProv.authinfo.companyType == CompanyEnum.MultiToken) {
              if (element.branchId == widget.empDets?.branchId ||
                  element.branchId == chosenBranchId) {
                couterCount = num.parse(element.counter);
              }
            }
          });
        }
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: widget.uporadd
                ? whiteAppBar(context, LocaleKeys.Update_Employee.tr())
                : whiteAppBar(context, LocaleKeys.Create_Employee.tr()),
            body: bdp.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : bdp.error
                    ? Center(
                        child: Text(LocaleKeys
                            .Error_occured_while_fetching_branches.tr()),
                      )
                    : error
                        ? Center(
                            child: Text(
                                LocaleKeys.Error_fetching_counter_counts.tr()),
                          )
                        : Container(
                            alignment: Alignment.topCenter,
                            child: ConstrainedBox(
                              constraints: BoxConstraints(maxWidth: 1200),
                              child: SingleChildScrollView(
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      _selectBranch(),
                                      Consumer<DeptDataProv>(
                                        builder:
                                            (context, deptDataprov, child) {
                                          if (!deptDataprov.isLoading &&
                                              _chosenBranch == null) {
                                            return SizedBox();
                                          }
                                          if (deptDataprov.isLoading) {
                                            return Center(
                                              child:
                                                  CircularProgressIndicator(),
                                            );
                                          }
                                          if (deptDataprov.error) {
                                            return Center(
                                              child: Text(LocaleKeys
                                                      .Error_fetching_departments
                                                  .tr()),
                                            );
                                          }
                                          departmentsList =
                                              deptDataprov.deptsList;
                                          return Column(
                                            children: [
                                              uploadedImageMob != null
                                                  ? CircleAvatar(
                                                      radius: 60,
                                                      backgroundImage:
                                                          FileImage(
                                                        uploadedImageMob,
                                                      ),
                                                    )
                                                  : imagee != null
                                                      ? CircleAvatar(
                                                          radius: 60,
                                                          backgroundImage:
                                                              NetworkImage(
                                                                  imagee),
                                                        )
                                                      : SizedBox(),
                                              SizedBox(
                                                height: 20,
                                              ),
                                              ElevatedButton(
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(AppColor
                                                                .mainBlue)),
                                                onPressed: () async {
                                                  var img = await ImagePicker()
                                                      .getImage(
                                                          source: ImageSource
                                                              .gallery);
                                                  if (img != null) {
                                                    uploadedImageMob =
                                                        File(img.path);
                                                    filename = File(img.path
                                                        .split("/")
                                                        .last);
                                                    print(filename);
                                                    setState(() {});
                                                  }
                                                },
                                                child: Text(
                                                  LocaleKeys.Upload_Image.tr(),
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                              _textField(LocaleKeys.Name.tr(),
                                                  _nameC, false),
                                              widget.uporadd
                                                  ? Container()
                                                  : _textField(
                                                      LocaleKeys.Email_ID.tr(),
                                                      _emailC,
                                                      true),
                                              widget.uporadd
                                                  ? Container()
                                                  : _textField(
                                                      LocaleKeys.Password.tr(),
                                                      _passwordC,
                                                      false),
                                              _ptextField(
                                                  LocaleKeys.PhoneNo.tr(),
                                                  _phoneC,
                                                  false),
                                              Container(
                                                height: 50,
                                                child: Row(
                                                  children: [
                                                    Flexible(
                                                      child: authProv.authinfo
                                                                  .companyType ==
                                                              CompanyEnum
                                                                  .Booking
                                                          ? SizedBox()
                                                          : Container(
                                                              height:
                                                                  size.height *
                                                                      0.08,
                                                              width:
                                                                  size.width *
                                                                      0.5,
                                                              child: _textField(
                                                                  LocaleKeys
                                                                          .Counter
                                                                      .tr(),
                                                                  _counterC,
                                                                  false)),
                                                    ),
                                                    SizedBox(
                                                      width: 20,
                                                    ),
                                                    Text(
                                                        LocaleKeys.Status.tr()),
                                                    Switch(
                                                        value: employeeStatus,
                                                        onChanged: (val) {
                                                          setState(() {
                                                            employeeStatus =
                                                                val;
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
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 8,
                                                        horizontal: 16),
                                                height: 50,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        child: InkWell(
                                                      onTap: () async {
                                                        if (authProv.authinfo
                                                                .companyType ==
                                                            CompanyEnum.Token) {
                                                          if (num.parse(_counterC
                                                                      .text) >
                                                                  couterCount ||
                                                              num.parse(_counterC
                                                                      .text) ==
                                                                  0) {
                                                            AppToast.showErr(
                                                                LocaleKeys
                                                                        .Enter_valid_counter_number
                                                                    .tr());
                                                            return;
                                                          }
                                                        }
                                                        if (_formKey
                                                            .currentState
                                                            .validate()) {
                                                          if (_chosenBranch ==
                                                                  null ||
                                                              _chosenDept ==
                                                                  null) {
                                                            AppToast.showErr(
                                                                LocaleKeys
                                                                        .Choose_branch_and_department_value_properly
                                                                    .tr());
                                                          }
                                                          bool success = await EmployeeOperationProv()
                                                              .createEmployee(
                                                                  authProv
                                                                      .authinfo
                                                                      .jwtToken,
                                                                  uploadedImageMob,
                                                                  getDetails(),
                                                                  filename
                                                                      .toString(),
                                                                  widget
                                                                      .images);

                                                          if (success) {
                                                            Navigator
                                                                .pushReplacement(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                              HomePage(),
                                                                    ));
                                                          }
                                                        } else {
                                                          AppToast.showErr(
                                                              LocaleKeys
                                                                      .Fill_Missing_Value
                                                                  .tr());
                                                        }
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                vertical: 16),
                                                        decoration: BoxDecoration(
                                                            color: AppColor
                                                                .mainBlue,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        4)),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          widget.empDets == null
                                                              ? LocaleKeys.ADD
                                                                  .tr()
                                                              : LocaleKeys
                                                                  .UPDATE
                                                                  .tr(),
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    )),
                                                    SizedBox(
                                                      width: 25,
                                                    ),
                                                    Expanded(
                                                        child: InkWell(
                                                      onTap: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: CustomWidgets()
                                                          .hollowButton(
                                                              LocaleKeys.CANCEL
                                                                  .tr()),
                                                    ))
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
          LocaleKeys.Select_a_Branch.tr(),
          style: TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.w500),
        ),
        onChanged: (String val) {
          int _branchId;

          branchesList.forEach((key, value) {
            if (value == val) {
              _branchId = key;
              chosenBranchId = _branchId;
            }
          });
          Provider.of<DeptDataProv>(context, listen: false).getDepts(
              Provider.of<AuthProv>(context, listen: false).authinfo.jwtToken,
              _branchId);
          setState(() {
            _chosenBranch = val;
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
          LocaleKeys.Select_a_DepartmentService.tr(),
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

  Widget _textField(
      String hintText, TextEditingController controller, bool email) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(4)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      child: TextFormField(
        controller: controller,
        validator: (value) => value.isEmpty ? "Please enter a $hintText" : null,
        decoration: InputDecoration(
          hintText: hintText,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget _ptextField(
      String hintText, TextEditingController controller, bool email) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(4)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      child: TextFormField(
        keyboardType: TextInputType.phone,
        controller: controller,
        validator: (value) => value.isEmpty ? "Please enter a $hintText" : null,
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
    int _branchId;

    branchesList.forEach((key, value) {
      if (value == _chosenBranch) {
        _branchId = key;
      }
    });
    return widget.empDets != null
        ? EmployeeModel(
            name: _nameC.text,
            email: _emailC.text,
            phoneNo: _phoneC.text,
            password: _passwordC.text,
            counterNumber: _counterC.text.length == 0 ? null : _counterC.text,
            branchId: _branchId,
            employeeId: widget.empDets.employeeId,
            empStatus: employeeStatus ? 1 : 0,
            req: 'update',
            services: _chosenDept,
            departments: _chosenDept)
        : EmployeeModel(
            name: _nameC.text,
            email: _emailC.text,
            phoneNo: _phoneC.text,
            password: _passwordC.text,
            counterNumber: _counterC.text.length == 0 ? null : (_counterC.text),
            branchId: _branchId,
            //  employeeId: widget.empDets.employeeId,
            empStatus: employeeStatus ? 1 : 0,
            req: 'create',
            services: _chosenDept,
            departments: _chosenDept);
  }
}
