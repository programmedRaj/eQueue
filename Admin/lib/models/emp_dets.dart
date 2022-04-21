import 'package:json_annotation/json_annotation.dart';

import 'package:equeue_admin/enums/company_enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'emp_dets.g.dart';

@JsonSerializable()
class EmpDets {
  @JsonKey(name: 'email')
  final String? email;
  @JsonKey(name: 'id', defaultValue: 000)
  final int? empId;
  @JsonKey(name: 'status')
  final int? status;
  final String? name;

  EmpDets({this.status, this.email, this.empId, this.name});

  factory EmpDets.fromJson(Map<String, dynamic> json) =>
      _$EmpDetsFromJson(json);

  Map<String, dynamic> toJson() => _$EmpDetsToJson(this);
}
