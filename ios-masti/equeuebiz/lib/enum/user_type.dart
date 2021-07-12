import 'package:json_annotation/json_annotation.dart';

enum UserEnum {
  @JsonValue("company")
  Company,
  @JsonValue("employee")
  Employee,
}

String userEnumToString(UserEnum userEnum) {
  Map<UserEnum, String> helper = {
    UserEnum.Company: "Company",
    UserEnum.Employee: "Employee",
  };

  return helper[userEnum];
}
