// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emp_dets.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmpDets _$EmpDetsFromJson(Map<String, dynamic> json) {
  return EmpDets(
    status: json['status'] as int?,
    email: json['email'] as String?,
    empId: json['id'] as int? ?? 0,
    name: json['name'] as String?,
  );
}

Map<String, dynamic> _$EmpDetsToJson(EmpDets instance) => <String, dynamic>{
      'email': instance.email,
      'id': instance.empId,
      'status': instance.status,
      'name': instance.name,
    };
