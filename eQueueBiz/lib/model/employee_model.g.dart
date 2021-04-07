// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeModel _$EmployeeModelFromJson(Map<String, dynamic> json) {
  return EmployeeModel(
    branchId: EmployeeModel._fromJson(json['branch_id']),
    departments: json['departments'] as String,
    email: json['email'] as String,
    employeeId: json['employee_id'] as int,
    name: json['name'] as String,
    password: json['password'] as String,
    phoneNo: json['number'] as String,
    profileUrl: json['profile_url'] as String,
    req: json['req'] as String,
    counterNumber: json['counter_no'] as int,
    services: json['services'] as String,
    empStatus: json['emp_status'] as int,
  );
}

Map<String, dynamic> _$EmployeeModelToJson(EmployeeModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'name': instance.name,
      'password': instance.password,
      'branch_id': instance.branchId,
      'number': instance.phoneNo,
      'profile_url': instance.profileUrl,
      'departments': instance.departments,
      'req': instance.req,
      'employee_id': instance.employeeId,
      'counter_no': instance.counterNumber,
      'services': instance.services,
      'emp_status': instance.empStatus,
    };
