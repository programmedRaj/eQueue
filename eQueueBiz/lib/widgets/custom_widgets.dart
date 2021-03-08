import 'package:equeuebiz/constants/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomWidgets {
  Widget filledButton(String text) {
    return Container(
      //width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
          color: AppColor.mainBlue, borderRadius: BorderRadius.circular(4)),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget hollowButton(String text) {
    return Container(
      // width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: AppColor.mainBlue)),
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(color: AppColor.mainBlue),
      ),
    );
  }
}
