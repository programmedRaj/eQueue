import 'dart:html';
import 'dart:typed_data';

import 'package:equeuebiz/constants/appcolor.dart';
import 'package:equeuebiz/constants/textstyle.dart';
import 'package:equeuebiz/model/company_model.dart';
import 'package:equeuebiz/providers/auth_prov.dart';
import 'package:equeuebiz/providers/create_edit_prov.dart';
import 'package:equeuebiz/services/app_toast.dart';
import 'package:equeuebiz/widgets/appbar.dart';
import 'package:equeuebiz/widgets/custom_widgets.dart';
import 'package:equeuebiz/widgets/resize_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateBranch extends StatefulWidget {
  @override
  _CreateBranchState createState() => _CreateBranchState();
}

class _CreateBranchState extends State<CreateBranch> {
  Uint8List uploadedImage;

  List<String> departments = [];
  TextEditingController _departmentController = TextEditingController();
  List<TimeOfDay> startTimeList = [];
  List<TimeOfDay> endTimeList = [];
  List<String> weekDays = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
  TextEditingController _branchNameController = TextEditingController();
  TextEditingController _branchNoController = TextEditingController();
  TextEditingController _phoneNoController = TextEditingController();
  TextEditingController _addr1Controller = TextEditingController();
  TextEditingController _addr2Controller = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _postalCodeController = TextEditingController();
  TextEditingController _provinceController = TextEditingController();
  TextEditingController _thresholdController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _geoLocationController = TextEditingController();

  AuthProv authProv;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 7; i++) {
      startTimeList.add(null);
      endTimeList.add(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    authProv = Provider.of<AuthProv>(context);
    return ChangeNotifierProvider<CreateEditBanchProv>(
      create: (_) => CreateEditBanchProv(),
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          appBar: whiteAppBar(context, "Create Branch"),
          body: Container(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 1200),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      uploadedImage != null
                          ? Image.memory(
                              uploadedImage,
                              height: size.height * 0.3,
                              width: size.width * 0.2,
                              fit: BoxFit.fill,
                            )
                          : SizedBox(),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black)),
                        onPressed: () async {
                          _startFilePicker();
                        },
                        child: Text(
                          'Upload Logo',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _textField("Branch Name", _branchNameController),
                      _textField("Branch Number", _branchNoController),
                      _textField("Address Line 1", _addr1Controller),
                      _textField("Address Line 2", _addr2Controller),
                      _textField("City", _cityController),
                      _textField("State/Province", _provinceController),
                      _textField("Contact", _phoneNoController),
                      _textField("Postal Code", _postalCodeController),
                      _textField("Threshold", _thresholdController),
                      _textField("Description", _descriptionController),
                      _textField("Geo Location", _geoLocationController),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Press a comma to add a department",
                        style: blackBoldFS16,
                      ),
                      _departmentTextfield(),
                      Wrap(
                        spacing: 8,
                        children: [
                          for (var item in departments) _departmentChip(item)
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Working hours",
                        style: blackBoldFS16,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      for (var i = 0; i < weekDays.length; i++)
                        _workingDay(
                            weekDays[i], startTimeList[i], endTimeList[i], i),
                      SizedBox(
                        height: 20,
                      ),
                      addCancel()
                    ],
                  ),
                ),
              )),
        ),
      ),
    );
  }

  _startFilePicker() async {
    InputElement uploadInput = FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      // read file content as dataURL
      final files = uploadInput.files;
      if (files.length == 1) {
        final file = files[0];
        FileReader reader = FileReader();

        reader.onLoadEnd.listen((e) {
          setState(() {
            uploadedImage = reader.result;
          });
        });

        reader.onError.listen((fileEvent) {
          setState(() {
            print("Some Error occured while reading the file");
          });
        });

        reader.readAsArrayBuffer(file);
      }
    });
  }

  Widget _departmentChip(String departmentNAme) {
    return InkWell(
      onTap: () {
        setState(() {
          departments.remove(departmentNAme);
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: AppColor.mainBlue)),
        child: Text(departmentNAme),
      ),
    );
  }

  Widget _departmentTextfield() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(4)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      child: TextField(
        controller: _departmentController,
        onChanged: (val) {
          if (val.endsWith(",")) {
            if (departments.contains(val.replaceAll(",", ""))) {
              AppToast.showErr("Already present");
              _departmentController.value = TextEditingValue.empty;

              return;
            }
            setState(() {
              departments.add(val.replaceAll(",", ""));
              _departmentController.value = TextEditingValue.empty;
            });
          }
        },
        decoration: InputDecoration(
          hintText: "Add departments",
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget _workingDay(
      String weekDay, TimeOfDay startTime, TimeOfDay endTime, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 50),
      child: Column(
        children: [
          Text(weekDay),
          SizedBox(
            height: 12,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    showTimePicker(
                            context: context, initialTime: TimeOfDay.now())
                        .then((value) {
                      setState(() {
                        startTimeList.insert(index, value);
                      });
                    });
                  },
                  child: Container(
                    height: 35,
                    width: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    child: startTime == null
                        ? Text("--:--")
                        : Text(startTime.hour.toString() +
                            " : " +
                            startTime.minute.toString()),
                  ),
                ),
                InkWell(
                  onTap: () {
                    showTimePicker(
                            context: context, initialTime: TimeOfDay.now())
                        .then((value) {
                      setState(() {
                        endTimeList.insert(index, value);
                      });
                    });
                  },
                  child: Container(
                    height: 35,
                    width: 100,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(10)),
                    alignment: Alignment.center,
                    child: endTime == null
                        ? Text("--:--")
                        : Text(endTime.hour.toString() +
                            " : " +
                            endTime.minute.toString()),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _textField(String hintText, TextEditingController _controller) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(4)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      child: TextField(
        controller: _controller,
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
          Expanded(child: Consumer<CreateEditBanchProv>(
            builder: (context, value, child) {
              return InkWell(
                onTap: () {
                  value.execCreateComppany(
                      uploadedImage, getDetails(), authProv.authinfo.jwtToken);
                },
                child: Container(
                  //width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                      color: AppColor.mainBlue,
                      borderRadius: BorderRadius.circular(4)),
                  alignment: Alignment.center,
                  child: Text(
                    "CREATE",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
          )),
          SizedBox(
            width: 25,
          ),
          Expanded(child: CustomWidgets().hollowButton("CANCEL"))
        ],
      ),
    );
  }

  BranchModel getDetails() {
    return BranchModel(
        branchName: _branchNameController.text,
        phoneNo: _phoneNoController.text,
        addr1: _addr1Controller.text,
        addr2: _addr2Controller.text,
        city: _cityController.text,
        postalCode: _postalCodeController.text,
        province: _provinceController.text,
        threshold: _thresholdController.text,
        geoLoaction: _geoLocationController.text,
        reqType: "create",
        department: {
          "department": ["dep1", "dep2"]
        });
  }

  Map<dynamic, dynamic> getWorkingHrs() {
    var workingHrs = {};
    for (int i = 0; i < weekDays.length; i++) {
      workingHrs.putIfAbsent(weekDays[i], () {
        return {
          "startTime": startTimeList[i].hour.toString() +
              ":" +
              startTimeList[i].minute.toString(),
          "endTime": endTimeList[i].hour.toString() +
              ":" +
              endTimeList[i].minute.toString()
        };
      });
    }
    return workingHrs;
  }
}
