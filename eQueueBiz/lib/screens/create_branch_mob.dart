import 'dart:io';
import 'dart:typed_data';
import 'package:equeuebiz/constants/appcolor.dart';
import 'package:equeuebiz/constants/textstyle.dart';
import 'package:equeuebiz/enum/company_enum.dart';
import 'package:equeuebiz/model/branch_model.dart';
import 'package:equeuebiz/model/branch_resp_model.dart';
import 'package:equeuebiz/providers/auth_prov.dart';
import 'package:equeuebiz/providers/create_edit_prov.dart';
import 'package:equeuebiz/screens/homepage.dart';
import 'package:equeuebiz/services/app_toast.dart';
import 'package:equeuebiz/widgets/appbar.dart';
import 'package:equeuebiz/widgets/custom_widgets.dart';
import 'package:equeuebiz/widgets/resize_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class CreateBranchMob extends StatefulWidget {
  final BranchRespModel branchDets;
  final String images;
  CreateBranchMob({this.branchDets, this.images});

  @override
  _CreateBranchMobState createState() => _CreateBranchMobState();
}

class _CreateBranchMobState extends State<CreateBranchMob> {
  File uploadedImageMob;
  bool _isErr = false;
  String imagee;
  File filename;
  String images;
  List<String> departments = [];
  TextEditingController _departmentController = TextEditingController();
  List<TimeOfDay> startTimeList = [null, null, null, null, null, null, null];
  List<TimeOfDay> endTimeList = [null, null, null, null, null, null, null];
  List<String> noOfBookings = [null, null, null, null, null, null, null];
  List<String> servicesName = [];
  List<String> serviceRates = [];
  List<String> servicesDesc = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<String> perDayHrs = [];
  List<TextEditingController> noofBookingsC = [];
  List<String> weekDays = [
    "monday",
    "tuesday",
    "wednesday",
    "thursday",
    "friday",
    "saturday",
    "sunday"
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
  TextEditingController _timezoneController = TextEditingController();
  TextEditingController _notifytimeDescController = TextEditingController();

  AuthProv authProv;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 7; i++) {
      noofBookingsC.add(TextEditingController());
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.branchDets != null) {
        setState(() {
          preFill();
        });
      }
    });
  }

  preFill() {
    setState(() {
      images = widget.images;
      imagee = 'https://www.nobatdeh.com/uploads/${widget.images}';
      print(imagee);
    });
    _branchNameController.text = widget.branchDets.branchName;
    _addr1Controller.text = widget.branchDets.addr1;
    _addr2Controller.text = widget.branchDets.addr2;
    _cityController.text = widget.branchDets.city;
    _provinceController.text = widget.branchDets.province;
    _phoneNoController.text = widget.branchDets.phoneNo;
    _postalCodeController.text = widget.branchDets.postalCode;
    _timezoneController.value =
        TextEditingValue(text: widget.branchDets.timeZone);

    _geoLocationController.text = widget.branchDets.geoLoaction;
    if (Provider.of<AuthProv>(context, listen: false).authinfo.companyType ==
        CompanyEnum.Booking) {
      print(widget.branchDets.services.serviceNames);
      servicesName = widget.branchDets.services.serviceNames;
      servicesDesc = widget.branchDets.services.servicesDesc;
      serviceRates = widget.branchDets.services.rates;
    } else {
      departments = widget.branchDets.department ?? [];
    }
    wrkingHrsPrefill();

    for (var i = 0; i < 6; i++) {
      noofBookingsC[i].text = widget.branchDets.bookingPerday[i];
    }
  }

  wrkingHrsPrefill() {
    WorkingHrs _tempWorkingHrs = widget.branchDets.workingHrs;

    startTimeList[0] = _tempWorkingHrs.monday.startTime == 'null:null' ||
            _tempWorkingHrs.monday.startTime == null
        ? null
        : TimeOfDay(
            hour: customTimeParser(_tempWorkingHrs.monday.startTime, 0),
            minute: customTimeParser(_tempWorkingHrs.monday.startTime, 1));
    startTimeList[1] = _tempWorkingHrs.tuesday.startTime == 'null:null' ||
            _tempWorkingHrs.tuesday.startTime == null
        ? null
        : TimeOfDay(
            hour: customTimeParser(_tempWorkingHrs.tuesday.startTime, 0),
            minute: customTimeParser(_tempWorkingHrs.tuesday.startTime, 1));
    startTimeList[2] = _tempWorkingHrs.wednesday.startTime == 'null:null' ||
            _tempWorkingHrs.wednesday.startTime == null
        ? null
        : TimeOfDay(
            hour: customTimeParser(_tempWorkingHrs.wednesday.startTime, 0),
            minute: customTimeParser(_tempWorkingHrs.wednesday.startTime, 1));
    startTimeList[3] = _tempWorkingHrs.thursday.startTime == 'null:null' ||
            _tempWorkingHrs.thursday.startTime == null
        ? null
        : TimeOfDay(
            hour: customTimeParser(_tempWorkingHrs.thursday.startTime, 0),
            minute: customTimeParser(_tempWorkingHrs.thursday.startTime, 1));
    startTimeList[4] = _tempWorkingHrs.friday.startTime == 'null:null' ||
            _tempWorkingHrs.friday.startTime == null
        ? null
        : TimeOfDay(
            hour: customTimeParser(_tempWorkingHrs.friday.startTime, 0),
            minute: customTimeParser(_tempWorkingHrs.friday.startTime, 1));
    startTimeList[5] = _tempWorkingHrs.saturday.startTime == 'null:null' ||
            _tempWorkingHrs.saturday.startTime == null
        ? null
        : TimeOfDay(
            hour: customTimeParser(_tempWorkingHrs.saturday.startTime, 0),
            minute: customTimeParser(_tempWorkingHrs.saturday.startTime, 1));
    startTimeList[6] = _tempWorkingHrs.sunday.startTime == 'null:null' ||
            _tempWorkingHrs.sunday.startTime == null
        ? null
        : TimeOfDay(
            hour: customTimeParser(_tempWorkingHrs.sunday.startTime, 0),
            minute: customTimeParser(_tempWorkingHrs.monday.startTime, 1));

    //=======================================================================================================//

    endTimeList[0] = _tempWorkingHrs.monday.endTime == 'null:null' ||
            _tempWorkingHrs.monday.endTime == null
        ? null
        : TimeOfDay(
            hour: customTimeParser(_tempWorkingHrs.monday.endTime, 0),
            minute: customTimeParser(_tempWorkingHrs.monday.endTime, 1));
    endTimeList[1] = _tempWorkingHrs.tuesday.endTime == 'null:null' ||
            _tempWorkingHrs.tuesday.endTime == null
        ? null
        : TimeOfDay(
            hour: customTimeParser(_tempWorkingHrs.tuesday.endTime, 0),
            minute: customTimeParser(_tempWorkingHrs.tuesday.endTime, 1));
    endTimeList[2] = _tempWorkingHrs.wednesday.endTime == 'null:null' ||
            _tempWorkingHrs.wednesday.endTime == null
        ? null
        : TimeOfDay(
            hour: customTimeParser(_tempWorkingHrs.wednesday.endTime, 0),
            minute: customTimeParser(_tempWorkingHrs.wednesday.endTime, 1));
    endTimeList[3] = _tempWorkingHrs.thursday.endTime == 'null:null' ||
            _tempWorkingHrs.thursday.endTime == null
        ? null
        : TimeOfDay(
            hour: customTimeParser(_tempWorkingHrs.thursday.endTime, 0),
            minute: customTimeParser(_tempWorkingHrs.thursday.endTime, 1));
    endTimeList[4] = _tempWorkingHrs.friday.endTime == 'null:null' ||
            _tempWorkingHrs.friday.endTime == null
        ? null
        : TimeOfDay(
            hour: customTimeParser(_tempWorkingHrs.friday.endTime, 0),
            minute: customTimeParser(_tempWorkingHrs.friday.endTime, 1));
    endTimeList[5] = _tempWorkingHrs.saturday.endTime == 'null:null' ||
            _tempWorkingHrs.saturday.endTime == null
        ? null
        : TimeOfDay(
            hour: customTimeParser(_tempWorkingHrs.saturday.endTime, 0),
            minute: customTimeParser(_tempWorkingHrs.saturday.endTime, 1));
    endTimeList[6] = _tempWorkingHrs.sunday.endTime == 'null:null' ||
            _tempWorkingHrs.sunday.endTime == null
        ? null
        : TimeOfDay(
            hour: customTimeParser(_tempWorkingHrs.sunday.endTime, 0),
            minute: customTimeParser(_tempWorkingHrs.monday.endTime, 1));
  }

  int customTimeParser(String text, int index) {
    return num.parse(text.split(":")[index]);
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
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
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        uploadedImageMob != null
                            ? CircleAvatar(
                                radius: 60,
                                backgroundImage: FileImage(
                                  uploadedImageMob,
                                ),
                              )
                            : imagee != null
                                ? CircleAvatar(
                                    radius: 60,
                                    backgroundImage: NetworkImage(imagee),
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
                            var img = await ImagePicker()
                                .getImage(source: ImageSource.gallery);
                            if (img != null) {
                              uploadedImageMob = File(img.path);
                              filename = File(img.path.split("/").last);
                              print(filename);
                              setState(() {});
                            }
                          },
                          child: Text(
                            'Upload Logo',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        _textField("Branch Name", _branchNameController, false),
                        _textField("Address Line 1", _addr1Controller, false),
                        _textField("Address Line 2", _addr2Controller, false),
                        _textField("City", _cityController, false),
                        _textField(
                            "State/Province", _provinceController, false),
                        _textField("Contact", _phoneNoController, true),
                        _textField("Postal Code", _postalCodeController, false),
                        authProv.authinfo.companyType == CompanyEnum.Booking
                            ? _textField(
                                "Time Zone", _timezoneController, false)
                            : SizedBox(),
                        authProv.authinfo.companyType == CompanyEnum.Booking
                            ? RaisedButton(
                                child: Text('Notify Time'),
                                onPressed: () {
                                  showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now())
                                      .then((value) {
                                    setState(() {
                                      _notifytimeDescController.text =
                                          value.toString();
                                    });
                                  });
                                })
                            : SizedBox(),
                        authProv.authinfo.companyType == CompanyEnum.Booking
                            ? SizedBox()
                            : _textField(
                                "No. of counters", _counterController, false),
                        authProv.authinfo.companyType != CompanyEnum.Booking
                            ? _textField("Threshold in minutes",
                                _thresholdController, true)
                            : SizedBox(),
                        _textField(
                            "Geo Location", _geoLocationController, true),
                        GestureDetector(
                            onTap: () {
                              _launchInBrowser('https://www.latlong.net/');
                            },
                            child: Text(
                              'Click here to get geolocation',
                              style: TextStyle(color: Colors.blue),
                            )),
                        SizedBox(
                          height: 8,
                        ),
                        authProv.authinfo.companyType == CompanyEnum.Booking
                            ? Column(
                                children: [
                                  _addServicesWidget(),
                                  Container(
                                      padding: EdgeInsets.all(10),
                                      child: Text(
                                          'Tap on the service block to remove')),
                                ],
                              )
                            : Column(
                                children: [
                                  Text(
                                    "Press a '.' to add a department",
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
                          "Working hours and \n Bookings accepted per day",
                          textAlign: TextAlign.center,
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
        _servicetextField("Service Name", _serviceNameController, false),
        _servicetextField("Service Rate", _serviceRateController, true),
        _servicetextField("Service Description", _serviceDescController, false),
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
        child: Text(
          departmentServiceNAme,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
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
          if (val.endsWith(".")) {
            if (departments.contains(val.replaceAll(".", ""))) {
              AppToast.showErr("Already present");
              _departmentController.value = TextEditingValue.empty;

              return;
            }
            setState(() {
              departments.add(val.replaceAll(".", ""));
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
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8),
      child: Column(
        children: [
          Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 15),
              child: Text(
                weekDay,
                style: TextStyle(fontWeight: FontWeight.bold),
              )),
          SizedBox(
            height: 3,
          ),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 1200),
            child: Row(
              mainAxisAlignment:
                  authProv.authinfo.companyType == CompanyEnum.Booking
                      ? MainAxisAlignment.spaceEvenly
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
                SizedBox(
                  width: 6,
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
                  width: authProv.authinfo.companyType == CompanyEnum.Booking
                      ? MediaQuery.of(context).size.width * 0.05
                      : 0,
                ),
                authProv.authinfo.companyType == CompanyEnum.Booking
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
                          controller: noofBookingsC[index],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
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

  Widget _textField(
      String hintText, TextEditingController _controller, bool number) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(4)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      child: TextFormField(
        validator: (value) => value.isEmpty ? 'Enter $hintText' : null,
        controller: _controller,
        keyboardType: number ? TextInputType.phone : TextInputType.text,
        decoration: InputDecoration(
          hintText: hintText,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }

  Widget _servicetextField(
      String hintText, TextEditingController _controller, bool number) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
          color: Colors.grey[300], borderRadius: BorderRadius.circular(4)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      child: TextFormField(
        controller: _controller,
        keyboardType: number ? TextInputType.phone : TextInputType.text,
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
                onTap: () async {
                  if (_formKey.currentState.validate()) {
                    var temp = getDetails();
                    if (temp == null) {
                      AppToast.showErr("Check your details");

                      return;
                    }

                    if (authProv.authinfo.companyType == CompanyEnum.Booking) {
                      if (servicesName.length == 0) {
                        AppToast.showErr("Atleast 1 service is required");
                        return;
                      }
                      if (perDayHrs.length == 0) {
                        AppToast.showErr("Atleast 1 working day is required");
                        return;
                      }
                    }
                    if (authProv.authinfo.companyType == CompanyEnum.Token ||
                        authProv.authinfo.companyType ==
                            CompanyEnum.MultiToken) {
                      if (departments.length == 0) {
                        AppToast.showErr("Atleast 1 department is required");
                        return;
                      }
                      if (perDayHrs.length == 0) {
                        AppToast.showErr("Atleast 1 working day is required");
                        return;
                      }
                    }
                    bool success = await value.execCreateComppany(
                        temp, authProv.authinfo.jwtToken,
                        companyLogoMob: uploadedImageMob,
                        filename: filename.toString(),
                        imagesdef: widget.images);
                    if (success) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ));
                    } else {
                      AppToast.showErr('Please Fill Missing Value');
                    }
                  } else {
                    AppToast.showErr('Please Fill Missing Value');
                  }
                },
                child: Container(
                  //width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                      color: AppColor.mainBlue,
                      borderRadius: BorderRadius.circular(4)),
                  alignment: Alignment.center,
                  child: Text(
                    widget.branchDets == null ? "CREATE" : "UPDATE",
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
    var temp = getbookingPerDayHrs();
    if (temp == null) {
      return null;
    }
    return BranchModel(
        branchName: _branchNameController.text,
        notify: _notifytimeDescController.text,
        timeZone: _timezoneController.text,
        phoneNo: _phoneNoController.text,
        addr1: _addr1Controller.text,
        addr2: _addr2Controller.text,
        city: _cityController.text,
        postalCode: _postalCodeController.text,
        province: _provinceController.text,
        threshold: _thresholdController.text,
        geoLoaction: _geoLocationController.text,
        bookingPerday: noofBookingsC.map((e) => e.text).toList(),
        services: getServices(),
        branchId: widget?.branchDets?.branchId?.toString() == null
            ? ""
            : widget?.branchDets?.branchId?.toString(),
        bookingPerDayhrs: temp,
        workingHrs: getWorkingHrs(),
        counter: _counterController.text,
        reqType: widget.branchDets == null ? "create" : "update",
        department: {"department": departments});
  }

  List day = [
    "monday",
    "tuesday",
    "wednesday",
    "thursday",
    "friday",
    "saturday",
    "sunday"
  ];

  List<String> getbookingPerDayHrs() {
    perDayHrs.clear();
    for (var i = 0; i < 7; i++) {
      if ((startTimeList[i] != null && endTimeList[i] != null)) {
        // perDayHrs.insert(i, "${endTimeList[i].hour - startTimeList[i]?.hour}");
        perDayHrs.add(
            "${(((endTimeList[i].hour) - (startTimeList[i]?.hour)).abs())}");
      } else if (startTimeList[i] == null && endTimeList[i] == null) {
        perDayHrs.add("");
      } else if (startTimeList[i] == null && endTimeList[i] != null) {
        AppToast.showErr("Check your timing field");

        return null;
      }
    }
    if (perDayHrs.isEmpty) {
      return ["a", "a", "a", "a", "a", "a", "a"];
    } else
      return perDayHrs;
  }

  Map<String, List<String>> getServices() {
    var services = {
      "rates": serviceRates,
      "services": servicesName,
      "services_desc": servicesDesc
    };
    var nonservice = {
      "rates": ["a"],
      "services": ["a"],
      "services_desc": ["a"]
    };

    return services.isEmpty ? nonservice : services;
  }

  Map<dynamic, dynamic> getWorkingHrs() {
    var workingHrs = {};
    for (int i = 0; i < weekDays.length; i++) {
      workingHrs.putIfAbsent(weekDays[i], () {
        return {
          "startTime": startTimeList[i] == null
              ? null
              : startTimeList[i]?.hour.toString() +
                  ":" +
                  startTimeList[i]?.minute.toString(),
          "endTime": endTimeList[i] == null
              ? null
              : endTimeList[i]?.hour.toString() +
                  ":" +
                  endTimeList[i]?.minute.toString()
        };
      });
    }
    return workingHrs;
  }
}
