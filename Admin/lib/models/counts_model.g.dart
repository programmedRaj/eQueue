// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counts_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountsModel _$CountsModelFromJson(Map<String, dynamic> json) {
  return CountsModel(
    branchCount: json['branch_count'] as int,
    compCount: json['comp_count'] as int,
    empCount: json['emp_count'] as int,
    userCount: json['users_count'] as int,
  );
}

Map<String, dynamic> _$CountsModelToJson(CountsModel instance) =>
    <String, dynamic>{
      'comp_count': instance.compCount,
      'branch_count': instance.branchCount,
      'emp_count': instance.empCount,
      'users_count': instance.userCount,
    };
