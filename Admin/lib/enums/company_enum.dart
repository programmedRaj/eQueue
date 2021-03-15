import 'package:json_annotation/json_annotation.dart';

enum CompanyEnum {
  @JsonValue("booking")
  Booking,
  @JsonValue("token")
  Token,
  @JsonValue("multitoken")
  MultiToken
}
