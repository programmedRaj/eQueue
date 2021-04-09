import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'employee_model.g.dart';

@JsonSerializable()
class EmployeeModel {
  final String email;
  final String name;
  final String password;
  @JsonKey(name: 'branch_id', fromJson: _fromJson)
  final int branchId;
  @JsonKey(name: 'number')
  final String phoneNo;
  @JsonKey(name: 'profile_url')
  final String profileUrl;
  final String departments;
  final String req;
  @JsonKey(name: 'employee_id')
  final int employeeId;
  @JsonKey(name: 'counter_no')
  int counterNumber;
  @JsonKey(name: 'ratings')
  int ratings;
  String services;
  @JsonKey(name: 'emp_status')
  int empStatus;

  EmployeeModel(
      {this.branchId,
      this.departments,
      this.email,
      this.employeeId,
      this.name,
      this.password,
      this.phoneNo,
      this.profileUrl,
      this.req,
      this.counterNumber,
      this.ratings,
      this.services,
      this.empStatus});

  factory EmployeeModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeModelToJson(this);

  static int _fromJson(val) => num.parse(val);
}
