// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_resp_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchRespModel _$BranchRespModelFromJson(Map<String, dynamic> json) {
  return BranchRespModel(
    addr1: json['address1'] as String,
    addr2: json['address2'] as String,
    bookingPerday:
        (json['booking_per_day'] as List)?.map((e) => e as String)?.toList(),
    bookingPerDayhrs:
        (json['per_day_hours'] as List)?.map((e) => e as String)?.toList(),
    branchId: json['id'] as String,
    branchName: json['bname'] as String,
    city: json['city'] as String,
    department: json['department'] as Map<String, dynamic>,
    geoLoaction: json['geolocation'] as String,
    notify: json['notify_time'] as String,
    phoneNo: json['phone_number'] as String,
    postalCode: json['postalcode'] as String,
    province: json['province'] as String,
    services: json['services'] == null
        ? null
        : Services.fromJson(json['services'] as Map<String, dynamic>),
    threshold: json['threshold'] as String,
    timeZone: json['timezone'] as String,
    workingHrs: json['working_hours'] as Map<String, dynamic>,
    counter: json['counter_count'] as String,
  );
}

Map<String, dynamic> _$BranchRespModelToJson(BranchRespModel instance) =>
    <String, dynamic>{
      'bname': instance.branchName,
      'phone_number': instance.phoneNo,
      'address1': instance.addr1,
      'address2': instance.addr2,
      'city': instance.city,
      'postalcode': instance.postalCode,
      'geolocation': instance.geoLoaction,
      'province': instance.province,
      'working_hours': instance.workingHrs,
      'services': instance.services,
      'timezone': instance.timeZone,
      'notify_time': instance.notify,
      'booking_per_day': instance.bookingPerday,
      'per_day_hours': instance.bookingPerDayhrs,
      'threshold': instance.threshold,
      'department': instance.department,
      'id': instance.branchId,
      'counter_count': instance.counter,
    };

Services _$ServicesFromJson(Map<String, dynamic> json) {
  return Services(
    rates: (json['rates'] as List)?.map((e) => e as String)?.toList(),
    serviceNames: (json['services'] as List)?.map((e) => e as String)?.toList(),
    servicesDesc:
        (json['services_desc'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ServicesToJson(Services instance) => <String, dynamic>{
      'rates': instance.rates,
      'services': instance.serviceNames,
      'services_desc': instance.servicesDesc,
    };