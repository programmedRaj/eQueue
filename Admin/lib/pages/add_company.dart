import 'dart:io';

import 'package:equeue_admin/constants/appcolor.dart';
import 'package:equeue_admin/enums/company_enum.dart';
import 'package:equeue_admin/utils.dart';
import 'package:flutter/material.dart';

class AddCompany extends StatefulWidget {
  @override
  _AddCompanyState createState() => _AddCompanyState();
}

class _AddCompanyState extends State<AddCompany> {
  String _logoPath;
  CompanyEnum selectedType;

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Company"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  _logoPath != null
                      ? Image.network(
                          _logoPath,
                          height: _height * 0.3,
                          width: _width * 0.2,
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
                      String imagePath = await getImage(context);
                      setState(() {
                        _logoPath = imagePath;
//                vm.image = image;
                      });
                    },
                    child: Text(
                      'Upload Logo',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              TextField(
                decoration: InputDecoration(hintText: "Name"),
              ),
              TextField(
                decoration: InputDecoration(hintText: "Description"),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  radioButton("Booking", type: CompanyEnum.Booking),
                  radioButton("Token", type: CompanyEnum.Token),
                  radioButton("Multi-Token", type: CompanyEnum.MultiToken)
                ],
              ),
              selectedType == null
                  ? SizedBox()
                  : selectedType == CompanyEnum.Booking
                      ? bookingUI()
                      : selectedType == CompanyEnum.MultiToken
                          ? multiTokenUI()
                          : SizedBox(),
              selectedType == null ? SizedBox() : createButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget radioButton(String text, {CompanyEnum type}) {
    return InkWell(
      onTap: () {
        setState(() {
          selectedType = type;
        });
      },
      child: Row(
        children: [
          Container(
            height: 15,
            width: 15,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.black)),
            child: Container(
              decoration: BoxDecoration(
                  color:
                      selectedType == type ? Colors.black : Colors.transparent,
                  shape: BoxShape.circle),
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Text(text)
        ],
      ),
    );
  }

  Widget bookingUI() {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(hintText: "Bank Name"),
        ),
        TextField(
          decoration: InputDecoration(hintText: "Bank Branch"),
        ),
        TextField(
          decoration: InputDecoration(hintText: "Account Number"),
        ),
        TextField(
          decoration: InputDecoration(hintText: "IFSC Code"),
        ),
      ],
    );
  }

  Widget multiTokenUI() {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(hintText: "Add one-liner"),
        ),
      ],
    );
  }

  Widget createButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black)),
        onPressed: () async {},
        child: Text(
          'Create',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
