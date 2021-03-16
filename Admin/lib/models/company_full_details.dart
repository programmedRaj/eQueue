import 'package:equeue_admin/enums/company_enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'company_full_details.g.dart';

@JsonSerializable()
class CompanyFullDetails {
  @JsonKey(name: "comp_emails_status")
  List<CompEmailStatus> compEmailStatusList;
  @JsonKey(name: "companies")
  List<CompanyDets> companyDetsList;

  CompanyFullDetails({this.compEmailStatusList, this.companyDetsList});

  factory CompanyFullDetails.fromJson(Map<String, dynamic> json) =>
      _$CompanyFullDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyFullDetailsToJson(this);
}

@JsonSerializable()
class CompEmailStatus {
  @JsonKey(name: "created_on")
  final String createdOn;
  final String email;
  final int status;

  CompEmailStatus({this.createdOn, this.email, this.status});

  factory CompEmailStatus.fromJson(Map<String, dynamic> json) =>
      _$CompEmailStatusFromJson(json);

  Map<String, dynamic> toJson() => _$CompEmailStatusToJson(this);
}

@JsonSerializable()
class CompanyDets {
  String name;
  @JsonKey(name: "descr")
  String desc;

  @JsonKey(name: "bankname")
  String bankName;
  @JsonKey(name: "ifsc")
  String ifscCode;
  @JsonKey(name: "account_number")
  String accountNo;
  @JsonKey(name: "account_name")
  String accountName;
  @JsonKey(name: "oneliner")
  String onleLiner;
  @JsonKey(name: "type")
  CompanyEnum accType;
  @JsonKey(name: "profile_url")
  String profileUrl;
  @JsonKey(name: "money_earned")
  String moneyEarned;
  @JsonKey(name: "earned_till_date")
  String earnedTillDate;
  @JsonKey(name: "id")
  int id;

  CompanyDets(
      {this.accType,
      this.accountName,
      this.accountNo,
      this.bankName,
      this.desc,
      this.earnedTillDate,
      this.id,
      this.ifscCode,
      this.moneyEarned,
      this.name,
      this.onleLiner,
      this.profileUrl});

  factory CompanyDets.fromJson(Map<String, dynamic> json) =>
      _$CompanyDetsFromJson(json);

  Map<String, dynamic> toJson() => _$CompanyDetsToJson(this);
}
