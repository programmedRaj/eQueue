// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_company.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddCompany _$AddCompanyFromJson(Map<String, dynamic> json) {
  return AddCompany(
    accType: _$enumDecodeNullable(_$CompanyEnumEnumMap, json['acc_type']),
    accountName: json['accountname'] as String?,
    accountNo: json['accountnumber'] as String?,
    bankName: json['bankname'] as String?,
    desc: json['desc'] as String?,
    ifscCode: json['ifsc_code'] as String?,
    name: json['name'] as String?,
    onleLiner: json['oneliner'] as String?,
    email: json['email'] as String?,
    password: json['password'] as String?,
    companyId: json['companyId'] as int?,
  );
}

Map<String, dynamic> _$AddCompanyToJson(AddCompany instance) =>
    <String, dynamic>{
      'name': instance.name,
      'desc': instance.desc,
      'email': instance.email,
      'password': instance.password,
      'bankname': instance.bankName,
      'ifsc_code': instance.ifscCode,
      'accountnumber': instance.accountNo,
      'accountname': instance.accountName,
      'oneliner': instance.onleLiner,
      'acc_type': _$CompanyEnumEnumMap[instance.accType!],
      'companyId': instance.companyId,
    };

T? _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value =
      enumValues.entries.singleWhereOrNull((e) => e.value == source)?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T? _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T? unknownValue,
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
