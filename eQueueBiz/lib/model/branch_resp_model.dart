import 'dart:convert';

import 'package:equeuebiz/enum/company_enum.dart';
import 'package:equeuebiz/enum/user_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'branch_resp_model.g.dart';

@JsonSerializable()
class BranchRespModel {
  @JsonKey(name: "bname")
  String branchName;
  @JsonKey(name: "phone_number")
  String phoneNo;
  @JsonKey(name: "address1")
  String addr1;
  @JsonKey(name: "address2")
  String addr2;
  @JsonKey(name: "city")
  String city;
  @JsonKey(name: "postalcode")
  String postalCode;
  @JsonKey(name: "geolocation")
  String geoLoaction;
  @JsonKey(name: "province")
  String province;
  @JsonKey(name: "working_hours")
  Map<dynamic, dynamic> workingHrs;
  @JsonKey(name: "services")
  Services services;
  @JsonKey(name: "timezone")
  String timeZone;
  @JsonKey(name: "notify_time")
  String notify;
  @JsonKey(name: "booking_per_day")
  List<String> bookingPerday;
  @JsonKey(name: "per_day_hours")
  List<String> bookingPerDayhrs;
  @JsonKey(name: "threshold")
  String threshold;
  @JsonKey(name: "department")
  Map<String, dynamic> department;
  @JsonKey(name: "id")
  String branchId;
  @JsonKey(name: "counter_count")
  String counter;

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
      this.services,
      this.threshold,
      this.timeZone,
      this.workingHrs,
      this.counter});

  factory BranchRespModel.fromJson(Map<String, dynamic> json) =>
      _$BranchRespModelFromJson(json);

  Map<String, dynamic> toJson() => _$BranchRespModelToJson(this);
}

@JsonSerializable()
class Services {
  List<String> rates;
  @JsonKey(name: "services")
  List<String> serviceNames;
  @JsonKey(name: "services_desc")
  List<String> servicesDesc;

  Services({this.rates, this.serviceNames, this.servicesDesc});

  factory Services.fromJson(Map<String, dynamic> json) =>
      _$ServicesFromJson(json);

  Map<String, dynamic> toJson() => _$ServicesToJson(this);
}
