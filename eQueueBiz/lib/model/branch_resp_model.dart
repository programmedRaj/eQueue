import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'branch_resp_model.g.dart';

@JsonSerializable()
class BranchRespModel {
  @JsonKey(name: "bname")
  String? branchName;
  @JsonKey(name: "bdesc")
  String? branchDesc;
  @JsonKey(name: "phone_number")
  String? phoneNo;
  @JsonKey(name: "address1")
  String? addr1;
  @JsonKey(name: "address2")
  String? addr2;
  @JsonKey(name: "city")
  String? city;
  @JsonKey(name: "postalcode")
  String? postalCode;
  @JsonKey(name: "geolocation")
  String? geoLoaction;
  @JsonKey(name: "province")
  String? province;
  @JsonKey(name: "profile_photo_url")
  String? profile_photo_url;
  @JsonKey(name: "working_hours")
  WorkingHrs? workingHrs;
  @JsonKey(name: "services")
  Services? services;
  @JsonKey(name: "timezone")
  String? timeZone;
  @JsonKey(name: "notify_time")
  String? notify;
  @JsonKey(name: "booking_per_day")
  List<String>?
      bookingPerday; // model me image daala hi nhi haiii bhaii kaise hoga
  @JsonKey(name: "per_day_hours")
  List<String>? bookingPerDayhrs;
  @JsonKey(name: "threshold")
  String? threshold;
  @JsonKey(name: "department")
  List<String>? department;
  @JsonKey(name: "id")
  int? branchId;
  @JsonKey(name: "counter_count")
  String? counter;

  BranchRespModel(
      {this.addr1,
      this.addr2,
      this.bookingPerday,
      this.bookingPerDayhrs,
      this.branchId,
      this.branchName,
      this.city,
      this.department,
      this.geoLoaction,
      this.notify,
      this.phoneNo,
      this.postalCode,
      this.province,
      this.profile_photo_url,
      this.services,
      this.threshold,
      this.timeZone,
      this.workingHrs,
      this.counter,
      this.branchDesc});

  factory BranchRespModel.fromJson(Map<String, dynamic> json) =>
      _$BranchRespModelFromJson(json);

  Map<String, dynamic> toJson() => _$BranchRespModelToJson(this);
}

@JsonSerializable()
class Services {
  List<String>? rates;
  @JsonKey(name: "services")
  List<String>? serviceNames;
  @JsonKey(name: "services_desc")
  List<String>? servicesDesc;

  Services({this.rates, this.serviceNames, this.servicesDesc});

  factory Services.fromJson(Map<String, dynamic> json) =>
      _$ServicesFromJson(json);

  Map<String, dynamic> toJson() => _$ServicesToJson(this);
}

@JsonSerializable()
class WorkingHrs {
  @JsonKey(name: "monday")
  WhrsTiming? monday;
  @JsonKey(name: "tuesday")
  WhrsTiming? tuesday;
  @JsonKey(name: "wednesday")
  WhrsTiming? wednesday;
  @JsonKey(name: "thursday")
  WhrsTiming? thursday;
  @JsonKey(name: "friday")
  WhrsTiming? friday;
  @JsonKey(name: "saturday")
  WhrsTiming? saturday;
  @JsonKey(name: "sunday")
  WhrsTiming? sunday;

  WorkingHrs(
      {this.friday,
      this.monday,
      this.saturday,
      this.sunday,
      this.thursday,
      this.tuesday,
      this.wednesday});

  factory WorkingHrs.fromJson(Map<String, dynamic> json) =>
      _$WorkingHrsFromJson(json);

  Map<String, dynamic> toJson() => _$WorkingHrsToJson(this);
}

@JsonSerializable()
class WhrsTiming {
  String? startTime;
  String? endTime;

  WhrsTiming({this.endTime, this.startTime});

  factory WhrsTiming.fromJson(Map<String, dynamic> json) =>
      _$WhrsTimingFromJson(json);

  Map<String, dynamic> toJson() => _$WhrsTimingToJson(this);
}
