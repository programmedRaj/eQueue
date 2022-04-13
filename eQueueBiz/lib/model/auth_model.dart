import 'package:collection/collection.dart';
import 'package:equeuebiz/enum/company_enum.dart';
import 'package:equeuebiz/enum/user_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_model.g.dart';

@JsonSerializable()
class AuthModel {
  @JsonKey(name: "token")
  String? jwtToken;
  @JsonKey(name: "comp_type")
  CompanyEnum? companyType;
  @JsonKey(name: "type")
  UserEnum? userType;

  AuthModel({this.companyType, this.jwtToken, this.userType});

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthModelToJson(this);
}
