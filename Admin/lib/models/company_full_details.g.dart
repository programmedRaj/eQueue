// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'company_full_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompanyFullDetails _$CompanyFullDetailsFromJson(Map<String, dynamic> json) {
  return CompanyFullDetails(
    compEmailStatusList: (json['comp_emails_status'] as List)
        ?.map((e) => e == null
            ? null
            : CompEmailStatus.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    companyDetsList: (json['companies'] as List)
        ?.map((e) =>
            e == null ? null : CompanyDets.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$CompanyFullDetailsToJson(CompanyFullDetails instance) =>
    <String, dynamic>{
      'comp_emails_status': instance.compEmailStatusList,
      'companies': instance.companyDetsList,
    };

CompEmailStatus _$CompEmailStatusFromJson(Map<String, dynamic> json) {
  return CompEmailStatus(
    createdOn: json['created_on'] as String,
    email: json['email'] as String,
    status: json['status'] as int,
  );
}

Map<String, dynamic> _$CompEmailStatusToJson(CompEmailStatus instance) =>
    <String, dynamic>{
      'created_on': instance.createdOn,
      'email': instance.email,
      'status': instance.status,
    };

CompanyDets _$CompanyDetsFromJson(Map<String, dynamic> json) {
  return CompanyDets(
    accType: _$enumDecodeNullable(_$CompanyEnumEnumMap, json['type']),
    accountName: json['account_name'] as String,
    accountNo: json['account_number'] as String,
    bankName: json['bankname'] as String,
    desc: json['descr'] as String,
    earnedTillDate: json['earned_till_date'] as String,
    id: json['id'] as int,
    ifscCode: json['ifsc'] as String,
    moneyEarned: json['money_earned'] as String,
    name: json['name'] as String,
    onleLiner: json['oneliner'] as String,
    profileUrl: json['profile_url'] as String,
  );
}

Map<String, dynamic> _$CompanyDetsToJson(CompanyDets instance) =>
    <String, dynamic>{
      'name': instance.name,
      'descr': instance.desc,
      'bankname': instance.bankName,
      'ifsc': instance.ifscCode,
      'account_number': instance.accountNo,
      'account_name': instance.accountName,
      'oneliner': instance.onleLiner,
      'type': _$CompanyEnumEnumMap[instance.accType],
      'profile_url': instance.profileUrl,
      'money_earned': instance.moneyEarned,
      'earned_till_date': instance.earnedTillDate,
      'id': instance.id,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$CompanyEnumEnumMap = {
  CompanyEnum.Booking: 'booking',
  CompanyEnum.Token: 'token',
  CompanyEnum.MultiToken: 'multitoken',
};
