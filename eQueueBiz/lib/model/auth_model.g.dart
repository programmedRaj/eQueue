// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthModel _$AuthModelFromJson(Map<String, dynamic> json) {
  return AuthModel(
    companyType: _$enumDecodeNullable(_$CompanyEnumEnumMap, json['comp_type']),
    jwtToken: json['token'] as String?,
    userType: _$enumDecodeNullable(_$UserEnumEnumMap, json['type']),
  );
}

Map<String, dynamic> _$AuthModelToJson(AuthModel instance) => <String, dynamic>{
      'token': instance.jwtToken,
      'comp_type': _$CompanyEnumEnumMap[instance.companyType!],
      'type': _$UserEnumEnumMap[instance.userType!],
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

const _$UserEnumEnumMap = {
  UserEnum.Company: 'company',
  UserEnum.Employee: 'employee',
};
