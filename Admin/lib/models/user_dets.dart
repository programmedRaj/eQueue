import 'package:json_annotation/json_annotation.dart';

import 'package:equeue_admin/enums/company_enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dets.g.dart';

@JsonSerializable()
class UserDets {
  String? money;
  final String? name;
  @JsonKey(name: 'phone_number')
  final String? contact;
  @JsonKey(name: 'id')
  final int? userId;

  UserDets({this.contact, this.money, this.name, this.userId});

  factory UserDets.fromJson(Map<String, dynamic> json) =>
      _$UserDetsFromJson(json);

  Map<String, dynamic> toJson() => _$UserDetsToJson(this);
}
