import 'package:json_annotation/json_annotation.dart';

part 'employee_model.g.dart';

@JsonSerializable()
class EmployeeModel {
  final String email;
  final String name;
  final String password;
  @JsonKey(name: 'branch_id')
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
  String services;

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
      this.services});

  factory EmployeeModel.fromJson(Map<String, dynamic> json) =>
      _$EmployeeModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeModelToJson(this);
}
