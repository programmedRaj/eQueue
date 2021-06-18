// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dets.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDets _$UserDetsFromJson(Map<String, dynamic> json) {
  return UserDets(
      name: json['name'] as String,
      money: json['money'] as String,
      contact: json['phone_number'] as String,
      userId: json['id'] as int);
}

Map<String, dynamic> _$UserDetsToJson(UserDets instance) => <String, dynamic>{
      'money': instance.money,
      'name': instance.name,
      'phone_number': instance.contact,
      'id': instance.userId
    };
