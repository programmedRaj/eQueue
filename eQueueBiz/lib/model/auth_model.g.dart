// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthModel _$AuthModelFromJson(Map<String, dynamic> json) {
  return AuthModel(
    companyType: _$enumDecode(_$CompanyEnumEnumMap, json['comp_type']),
    jwtToken: json['token'] as String,
    userType: _$enumDecode(_$UserEnumEnumMap, json['type']),
  );
}

Map<String, dynamic> _$AuthModelToJson(AuthModel instance) => <String, dynamic>{
      'token': instance.jwtToken,
      'comp_type': _$CompanyEnumEnumMap[instance.companyType],
      'type': _$UserEnumEnumMap[instance.userType],
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object source, {
  K unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
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
