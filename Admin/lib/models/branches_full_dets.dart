import 'package:json_annotation/json_annotation.dart';

import 'package:equeue_admin/enums/company_enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'branches_full_dets.g.dart';

@JsonSerializable()
class BranchFullDetails {
  @JsonKey(name: 'bname')
  final String? name;
  @JsonKey(name: 'money_earned', defaultValue: '0')
  final String? moneyEarned;
  @JsonKey(name: 'phone_number')
  final String? contact;
  final int? id;

  BranchFullDetails({this.contact, this.moneyEarned, this.name, this.id});

  factory BranchFullDetails.fromJson(Map<String, dynamic> json) =>
      _$BranchFullDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$BranchFullDetailsToJson(this);
}
