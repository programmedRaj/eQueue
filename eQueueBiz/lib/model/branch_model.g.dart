// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchModel _$BranchModelFromJson(Map<String, dynamic> json) {
  return BranchModel(
    addr1: json['addr1'] as String,
    addr2: json['addr2'] as String,
    bookingPerday:
        (json['bookingPerday'] as List)?.map((e) => e as String)?.toList(),
    bookingPerDayhrs:
        (json['bookingPerDayhrs'] as List)?.map((e) => e as String)?.toList(),
    branchId: json['branchId'] as String,
    branchName: json['branchName'] as String,
    city: json['city'] as String,
    department: json['department'] as Map<String, dynamic>,
    geoLoaction: json['geoLoaction'] as String,
    notify: json['notify'] as String,
    phoneNo: json['phoneNo'] as String,
    postalCode: json['postalCode'] as String,
    province: json['province'] as String,
    reqType: json['reqType'] as String,
    services: json['services'] as Map<String, dynamic>,
    threshold: json['threshold'] as String,
    timeZone: json['timeZone'] as String,
    workingHrs: json['workingHrs'] as Map<String, dynamic>,
    counter: json['counter'] as String,
  );
}

Map<String, dynamic> _$BranchModelToJson(BranchModel instance) =>
    <String, dynamic>{
      'branchName': instance.branchName,
      'phoneNo': instance.phoneNo,
      'addr1': instance.addr1,
      'addr2': instance.addr2,
      'city': instance.city,
      'postalCode': instance.postalCode,
      'geoLoaction': instance.geoLoaction,
      'province': instance.province,
      'workingHrs': instance.workingHrs,
      'services': instance.services,
      'timeZone': instance.timeZone,
      'notify': instance.notify,
      'bookingPerday': instance.bookingPerday,
      'bookingPerDayhrs': instance.bookingPerDayhrs,
      'reqType': instance.reqType,
      'threshold': instance.threshold,
      'department': instance.department,
      'branchId': instance.branchId,
      'counter': instance.counter,
    };
