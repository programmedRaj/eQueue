// import 'dart:html';
import 'dart:typed_data';

import 'package:equeuebiz/constants/appcolor.dart';
import 'package:equeuebiz/constants/textstyle.dart';
import 'package:equeuebiz/enum/company_enum.dart';
import 'package:equeuebiz/model/branch_model.dart';
import 'package:equeuebiz/providers/auth_prov.dart';
import 'package:equeuebiz/providers/create_edit_prov.dart';
import 'package:equeuebiz/services/app_toast.dart';
import 'package:equeuebiz/widgets/appbar.dart';
import 'package:equeuebiz/widgets/custom_widgets.dart';
import 'package:equeuebiz/widgets/resize_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateBranchWeb extends StatefulWidget {
  @override
  _CreateBranchWebState createState() => _CreateBranchWebState();
}

class _CreateBranchWebState extends State<CreateBranchWeb> {
  Uint8List? uploadedImage;
  bool _isErr = false;
  List<String> departments = [];
  TextEditingController _departmentController = TextEditingController();
  List<TimeOfDay?> startTimeList = [null, null, null, null, null, null, null];
  List<TimeOfDay?> endTimeList = [null, null, null, null, null, null, null];
  List<String?> noOfBookings = [null, null, null, null, null, null, null];
  List<String> servicesName = [];
  List<String> serviceRates = [];
  List<String> servicesDesc = [];
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
  TextEditingController _counterController = TextEditingController();
  TextEditingController _provinceController = TextEditingController();
  TextEditingController _thresholdController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _geoLocationController = TextEditingController();
  TextEditingController _serviceNameController = TextEditingController();
  TextEditingController _serviceRateController = TextEditingController();
  TextEditingController _serviceDescController = TextEditingController();

  late AuthProv authProv;

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
          appBar: whiteAppBar(context, "Create Branch") as PreferredSizeWidget?,
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
                              uploadedImage!,
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
                      authProv.authinfo!.companyType == CompanyEnum.Booking
                          ? SizedBox()
                          : _textField("No. of counters", _counterController),
                      authProv.authinfo!.companyType != CompanyEnum.Booking
                          ? _textField(
                              "Threshold in minutes", _thresholdController)
                          : SizedBox(),
                      _textField("Description", _descriptionController),
                      _textField("Geo Location", _geoLocationController),
                      SizedBox(
                        height: 8,
                      ),
                      authProv.authinfo!.companyType == CompanyEnum.Booking
                          ? _addServicesWidget()
                          : Column(
                              children: [
                                Text(
                                  "Press a comma to add a department",
                                  style: blackBoldFS16,
                                ),
                                _departmentTextfield(),
                                Wrap(
                                  spacing: 8,
                                  children: [
                                    for (var item in departments)
                                      _departmentServiceChip(item)
                                  ],
                                ),
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

  Widget _addServicesWidget() {
    return Column(
      children: [
        Text(
          "Enter Services",
          style: blackBoldFS16,
        ),
        _textField("Service Name", _serviceNameController),
        _textField("Service Rate", _serviceRateController),
        _textField("Service Description", _serviceDescController),
        ElevatedButton(
            onPressed: () {
              setState(() {
                if (_serviceNameController.text.length == 0 ||
                    _serviceNameController.text == null ||
                    _serviceRateController.text.length == 0 ||
                    _serviceRateController.text == null ||
                    _serviceDescController.text.length == 0 ||
                    _serviceDescController.text == null) {
                  AppToast.showErr("Field cannot be empty");
                  return;
                }

                if (servicesName.contains(_serviceNameController.text)) {
                  AppToast.showErr("Service already exists");
                  return;
                } else {
                  servicesName.add(_serviceNameController.text);
                  serviceRates.add(_serviceRateController.text);
                  servicesDesc.add(_serviceDescController.text);
                }
              });
            },
            child: Text("Add Service")),
        SizedBox(
          height: 10,
        ),
        Wrap(
          spacing: 8,
          children: [
            for (var item in servicesName)
              _departmentServiceChip(item, isService: true)
          ],
        ),
      ],
    );
  }

  _startFilePicker() async {
    /*  InputElement uploadInput = FileUploadInputElement();
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
    }); */
  }

  Widget _departmentServiceChip(String departmentServiceNAme,
      {bool isService = false}) {
    return InkWell(
      onTap: () {
        if (isService) {
          setState(() {
            for (int i = 0; i < servicesName.length; i++) {
              if (servicesName[i] == departmentServiceNAme) {
                servicesName.removeAt(i);
                serviceRates.removeAt(i);
                servicesDesc.removeAt(i);
              }
            }
          });
        } else {
          setState(() {
            departments.remove(departmentServiceNAme);
          });
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            border: Border.all(color: AppColor.mainBlue)),
        child: Text(departmentServiceNAme),
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
      String weekDay, TimeOfDay? startTime, TimeOfDay? endTime, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 50),
      child: Column(
        children: [
          Text(weekDay),
          SizedBox(
            height: 12,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1200),
            child: Row(
              mainAxisAlignment:
                  authProv.authinfo!.companyType == CompanyEnum.Booking
                      ? MainAxisAlignment.spaceAround
                      : MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    showTimePicker(
                            context: context, initialTime: TimeOfDay.now())
                        .then((value) {
                      setState(() {
                        startTimeList[index] = value;
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
                        endTimeList[index] = value;
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
                SizedBox(
                  width: authProv.authinfo!.companyType == CompanyEnum.Booking
                      ? MediaQuery.of(context).size.width * 0.05
                      : 0,
                ),
                authProv.authinfo!.companyType == CompanyEnum.Booking
                    ? Container(
                        width: MediaQuery.of(context).size.width * 0.2,
                        margin: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 16),
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(4)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 0),
                        child: TextField(
                          onChanged: (val) {
                            noOfBookings[index] = val;
                          },
                          decoration: InputDecoration(
                            hintText: "No. of bookings",
                            focusedBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                        ),
                      )
                    : SizedBox()
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
                  var temp = getDetails();
                  if (temp == null) {
                    return;
                  }
                  if (servicesName.length == 0) {
                    AppToast.showErr("Atleast 1 service is required");
                    return;
                  }
                  value.execCreateComppany(temp, authProv.authinfo!.jwtToken!,
                      companyLogo: uploadedImage);
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

  BranchModel? getDetails() {
    var temp = getbookingPerDayHrs();
    if (temp == null) {
      return null;
    }
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
        bookingPerday: noOfBookings,
        services: getServices(),
        bookingPerDayhrs: temp,
        workingHrs: getWorkingHrs(),
        counter: _counterController.text,
        reqType: "create",
        department: {
          "department": ["dep1", "dep2"]
        });
  }

  List<String>? getbookingPerDayHrs() {
    List<String> perDayHrs = [];
    for (var i = 0; i < startTimeList.length; i++) {
      if ((startTimeList[i] != null && endTimeList[i] != null)) {
        perDayHrs.insert(i,
            "${endTimeList[i]!.hour - startTimeList[i]!.hour}:${endTimeList[i]!.hour - startTimeList[i]!.hour}");
      } else if (startTimeList[i] == null && endTimeList[i] != null) {
        AppToast.showErr("Check your timing field");

        return null;
      }
    }
    return perDayHrs;
  }

  Map<String, List<String>> getServices() {
    var services = {
      "rates": serviceRates,
      "services": servicesName,
      "services_desc": servicesDesc
    };

    return services;
  }

  Map<dynamic, dynamic> getWorkingHrs() {
    var workingHrs = {};
    for (int i = 0; i < weekDays.length; i++) {
      workingHrs.putIfAbsent(weekDays[i], () {
        return {
          "startTime": startTimeList[i] == null
              ? null
              : startTimeList[i]!.hour.toString() +
                  ":" +
                  startTimeList[i]!.minute.toString(),
          "endTime": endTimeList[i] == null
              ? null
              : endTimeList[i]!.hour.toString() +
                  ":" +
                  endTimeList[i]!.minute.toString()
        };
      });
    }
    return workingHrs;
  }
}
