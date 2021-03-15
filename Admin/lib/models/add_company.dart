import 'package:equeue_admin/enums/company_enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'add_company.g.dart';

@JsonSerializable()
class AddCompany {
  String name;
  String desc;
  @JsonKey(name: "bankname")
  String bankName;
  @JsonKey(name: "ifsc_code")
  String ifscCode;
  @JsonKey(name: "accountnumber")
  String accountNo;
  @JsonKey(name: "accountname")
  String accountName;
  @JsonKey(name: "oneliner")
  String onleLiner;
  @JsonKey(name: "acc_type")
  CompanyEnum accType;

  AddCompany(
      {this.accType,
      this.accountName,
      this.accountNo,
      this.bankName,
      this.desc,
      this.ifscCode,
      this.name,
      this.onleLiner});

  factory AddCompany.fromJson(Map<String, dynamic> json) =>
      _$AddCompanyFromJson(json);

  Map<String, dynamic> toJson() => _$AddCompanyToJson(this);
}
