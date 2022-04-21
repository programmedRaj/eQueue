// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branches_full_dets.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchFullDetails _$BranchFullDetailsFromJson(Map<String, dynamic> json) {
  return BranchFullDetails(
    contact: json['phone_number'] as String?,
    moneyEarned: json['money_earned'] as String? ?? '0',
    name: json['bname'] as String?,
    id: json['id'] as int?,
  );
}

Map<String, dynamic> _$BranchFullDetailsToJson(BranchFullDetails instance) =>
    <String, dynamic>{
      'bname': instance.name,
      'money_earned': instance.moneyEarned,
      'phone_number': instance.contact,
      'id': instance.id,
    };
