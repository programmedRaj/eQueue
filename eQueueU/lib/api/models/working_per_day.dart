import 'dart:convert';

class Working {
  String day;
  String value;
  Working({
    this.day,
    this.value,
  });

  Working copyWith({
    String day,
    String value,
  }) {
    return Working(
      day: day ?? this.day,
      value: value ?? this.value,
    );
  }

  Working merge(Working model) {
    return Working(
      day: model.day ?? this.day,
      value: model.value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'value': value,
    };
  }

  factory Working.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Working(
      day: map['day'],
      value: map['value'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Working.fromJson(String source) =>
      Working.fromMap(json.decode(source));

  @override
  String toString() => 'Working(day: $day, value: $value)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Working && o.day == day && o.value == value;
  }

  @override
  int get hashCode => day.hashCode ^ value.hashCode;
}
