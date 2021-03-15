import 'dart:html';
import 'dart:typed_data';

import 'package:equeue_admin/constants/appcolor.dart';
import 'package:equeue_admin/enums/company_enum.dart';
import 'package:equeue_admin/models/add_company.dart';
import 'package:equeue_admin/providers/add_company_prov.dart';
import 'package:equeue_admin/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddCompanyPage extends StatefulWidget {
  @override
  _AddCompanyPageState createState() => _AddCompanyPageState();
}

class _AddCompanyPageState extends State<AddCompanyPage> {
  Uint8List uploadedImage;

  CompanyEnum selectedType;

  TextEditingController _nameC = TextEditingController();
  TextEditingController _descC = TextEditingController();
  TextEditingController _bankNameC = TextEditingController();
  TextEditingController _bankBranchC = TextEditingController();
  TextEditingController _accNoC = TextEditingController();
  TextEditingController _accNameC = TextEditingController();
  TextEditingController _ifscCodeC = TextEditingController();
  TextEditingController _onleLinerC = TextEditingController();

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
                  uploadedImage != null
                      ? Image.memory(
                          uploadedImage,
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
                      _startFilePicker();
                      /*  String imagePath = await getImage(context);
                      setState(() {
                        _logoPath = imagePath;
//                vm.image = image;
                      }); */
                    },
                    child: Text(
                      'Upload Logo',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              TextField(
                controller: _nameC,
                decoration: InputDecoration(hintText: "Name"),
              ),
              TextField(
                controller: _descC,
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
          controller: _bankNameC,
          decoration: InputDecoration(hintText: "Bank Name"),
        ),
        TextField(
          controller: _bankBranchC,
          decoration: InputDecoration(hintText: "Bank Branch"),
        ),
        TextField(
          controller: _accNoC,
          decoration: InputDecoration(hintText: "Account Number"),
        ),
        TextField(
          controller: _accNameC,
          decoration: InputDecoration(hintText: "Account Name"),
        ),
        TextField(
          controller: _ifscCodeC,
          decoration: InputDecoration(hintText: "IFSC Code"),
        ),
      ],
    );
  }

  Widget multiTokenUI() {
    return Column(
      children: [
        TextField(
          controller: _onleLinerC,
          decoration: InputDecoration(hintText: "Add one-liner"),
        ),
      ],
    );
  }

  AddCompany getDetails() {
    return AddCompany(
        accType: selectedType,
        accountName: _accNameC.text,
        accountNo: _accNoC.text,
        bankName: _bankNameC.text,
        desc: _descC.text,
        ifscCode: _ifscCodeC.text,
        name: _nameC.text,
        onleLiner: _onleLinerC.text);
  }

  Widget createButton() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.black)),
        onPressed: () async {
          Provider.of<AddCompanyProv>(context, listen: false)
              .execCreateComppany(uploadedImage, getDetails());
        },
        child: Text(
          'Create',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
