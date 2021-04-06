import 'dart:convert';

class Working {
  String day;
  String time;
  Working({
    this.day,
    this.time,
  });

  Working copyWith({
    String day,
    String time,
  }) {
    return Working(
      day: day ?? this.day,
      time: time ?? this.time,
    );
  }

  Working merge(Working model) {
    return Working(
      day: model.day ?? this.day,
      time: model.time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'time': time,
    };
  }

  factory Working.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Working(
      day: map['day'],
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Working.fromJson(String source) =>
      Working.fromMap(json.decode(source));

  @override
  String toString() => 'Working(day: $day, time: $time)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Working && o.day == day && o.time == time;
  }

  @override
  int get hashCode => day.hashCode ^ time.hashCode;
}
