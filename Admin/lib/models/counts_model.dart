import 'package:json_annotation/json_annotation.dart';

part 'counts_model.g.dart';

@JsonSerializable()
class CountsModel {
  @JsonKey(name: 'comp_count')
  int? compCount;
  @JsonKey(name: 'branch_count')
  int? branchCount;
  @JsonKey(name: 'emp_count')
  int? empCount;
  @JsonKey(name: 'users_count')
  int? userCount;

  CountsModel(
      {this.branchCount, this.compCount, this.empCount, this.userCount});

  factory CountsModel.fromJson(Map<String, dynamic> json) =>
      _$CountsModelFromJson(json);

  Map<String, dynamic> toJson() => _$CountsModelToJson(this);
}
