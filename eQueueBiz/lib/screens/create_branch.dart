import 'package:equeuebiz/constants/appcolor.dart';
import 'package:equeuebiz/constants/textstyle.dart';
import 'package:equeuebiz/widgets/appbar.dart';
import 'package:equeuebiz/widgets/custom_widgets.dart';
import 'package:equeuebiz/widgets/resize_helper.dart';
import 'package:flutter/material.dart';

class CreateBranch extends StatefulWidget {
  @override
  _CreateBranchState createState() => _CreateBranchState();
}

class _CreateBranchState extends State<CreateBranch> {
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
    return GestureDetector(
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
                    _textField("Branch Name"),
                    _textField("Branch Number"),
                    _textField("Address Line 1"),
                    _textField("Address Line 2"),
                    _textField("City"),
                    _textField("State/Province"),
                    _textField("Contact"),
                    _textField("Paisa"),
                    _textField("Description"),
                    _textField("Counter"),
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
    );
  }

  Widget _departmentChip(String departmentNAme) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          border: Border.all(color: AppColor.mainBlue)),
      child: Text(departmentNAme),
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
          Expanded(child: CustomWidgets().filledButton("CREATE")),
          SizedBox(
            width: 25,
          ),
          Expanded(child: CustomWidgets().hollowButton("CANCEL"))
        ],
      ),
    );
  }
}
