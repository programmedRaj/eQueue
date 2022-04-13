import 'package:json_annotation/json_annotation.dart';

enum CompanyEnum {
  @JsonValue("booking")
  Booking,
  @JsonValue("token")
  Token,
  @JsonValue("multitoken")
  MultiToken
}

String? companyEnumToString(CompanyEnum companyEnum) {
  Map<CompanyEnum, String> helper = {
    CompanyEnum.Booking: "booking",
    CompanyEnum.MultiToken: "multitoken",
    CompanyEnum.Token: "token"
  };

  return helper[companyEnum];
}
