// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_resp_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchRespModel _$BranchRespModelFromJson(Map<String, dynamic> json) {
  return BranchRespModel(
    addr1: json['address1'] as String,
    addr2: json['address2'] as String,
    bookingPerday: (jsonDecode(json['booking_per_day'] ?? '[]') as List)
        ?.map((e) => e as String)
        ?.toList(),
    bookingPerDayhrs: (jsonDecode(json['per_day_hours'] ?? '[]') as List)
        ?.map((e) => e as String)
        ?.toList(),
    branchId: json['id'] as int,
    branchName: json['bname'] as String,
    city: json['city'] as String,
    department: getDepts(json),
    geoLoaction: json['geolocation'] as String,
    notify: json['notify_time'] as String,
    phoneNo: json['phone_number'] as String,
    postalCode: json['postalcode'] as String,
    province: json['province'] as String,
    services: json['services'] == null
        ? null
        : Services.fromJson(
            jsonDecode(json['services']) as Map<String, dynamic>),
    threshold: json['threshold'] as String,
    timeZone: json['timezone'] as String,
    workingHrs: json['working_hours'] == null
        ? null
        : WorkingHrs.fromJson(
            jsonDecode(json['working_hours']) as Map<String, dynamic>),
    counter: json['counter_count'] as String,
  );
}

List<String> getDepts(Map json) {
  var temp;
  List tempList = [];
  List<String> tempLString = [];
  temp = (jsonDecode(json['department'] ?? "{}"));
  tempList = temp['department'];
  tempList.forEach((element) {
    tempLString.add(element as String);
  });

  return tempLString;
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

WorkingHrs _$WorkingHrsFromJson(Map<String, dynamic> json) {
  return WorkingHrs(
    friday: json['friday'] == null
        ? null
        : WhrsTiming.fromJson(json['friday'] as Map<String, dynamic>),
    monday: json['monday'] == null
        ? null
        : WhrsTiming.fromJson(json['monday'] as Map<String, dynamic>),
    saturday: json['saturday'] == null
        ? null
        : WhrsTiming.fromJson(json['saturday'] as Map<String, dynamic>),
    sunday: json['sunday'] == null
        ? null
        : WhrsTiming.fromJson(json['sunday'] as Map<String, dynamic>),
    thursday: json['thursday'] == null
        ? null
        : WhrsTiming.fromJson(json['thursday'] as Map<String, dynamic>),
    tuesday: json['tuesday'] == null
        ? null
        : WhrsTiming.fromJson(json['tuesday'] as Map<String, dynamic>),
    wednesday: json['wednesday'] == null
        ? null
        : WhrsTiming.fromJson(json['wednesday'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$WorkingHrsToJson(WorkingHrs instance) =>
    <String, dynamic>{
      'Monday': instance.monday,
      'Tuesday': instance.tuesday,
      'Wednesday': instance.wednesday,
      'Thursday': instance.thursday,
      'Friday': instance.friday,
      'Saturday': instance.saturday,
      'Sunday': instance.sunday,
    };

WhrsTiming _$WhrsTimingFromJson(Map<String, dynamic> json) {
  return WhrsTiming(
    endTime: json['endTime'] as String,
    startTime: json['startTime'] as String,
  );
}

Map<String, dynamic> _$WhrsTimingToJson(WhrsTiming instance) =>
    <String, dynamic>{
      'startTime': instance.startTime,
      'endTime': instance.endTime,
    };
