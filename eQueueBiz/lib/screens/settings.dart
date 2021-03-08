import 'package:equeuebiz/constants/appcolor.dart';
import 'package:equeuebiz/widgets/appbar.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  List<String> languagesList = ["English", "Hindi", "Spanish"];
  String _chosenLanguage = "English";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: whiteAppBar(context, "Settings"),
      body: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 1200),
        child: Column(
          children: [
            SizedBox(
              height: 15,
            ),
            _languageDropdown()
          ],
        ),
      ),
    );
  }

  Widget _languageDropdown() {
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
        value: _chosenLanguage,
        //elevation: 5,
        style: TextStyle(color: Colors.white),
        iconEnabledColor: Colors.black,
        items: languagesList.map<DropdownMenuItem<String>>((String value) {
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
            _chosenLanguage = value;
          });
        },
      ),
    );
  }
}
