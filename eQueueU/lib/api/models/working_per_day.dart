import 'dart:convert';

class Workinghrsperday {
  String monday;
  String tuesday;
  String wednesday;
  String thursday;
  String friday;
  String saturday;
  String sunday;
  Workinghrsperday({
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.saturday,
    this.sunday,
  });

  Workinghrsperday copyWith({
    String monday,
    String tuesday,
    String wednesday,
    String thursday,
    String friday,
    String saturday,
    String sunday,
  }) {
    return Workinghrsperday(
      monday: monday ?? this.monday,
      tuesday: tuesday ?? this.tuesday,
      wednesday: wednesday ?? this.wednesday,
      thursday: thursday ?? this.thursday,
      friday: friday ?? this.friday,
      saturday: saturday ?? this.saturday,
      sunday: sunday ?? this.sunday,
    );
  }

  Workinghrsperday merge(Workinghrsperday model) {
    return Workinghrsperday(
      monday: model.monday ?? this.monday,
      tuesday: model.tuesday ?? this.tuesday,
      wednesday: model.wednesday ?? this.wednesday,
      thursday: model.thursday ?? this.thursday,
      friday: model.friday ?? this.friday,
      saturday: model.saturday ?? this.saturday,
      sunday: model.sunday ?? this.sunday,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'monday': monday,
      'tuesday': tuesday,
      'wednesday': wednesday,
      'thursday': thursday,
      'friday': friday,
      'saturday': saturday,
      'sunday': sunday,
    };
  }

  factory Workinghrsperday.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Workinghrsperday(
      monday: map['monday'],
      tuesday: map['tuesday'],
      wednesday: map['wednesday'],
      thursday: map['thursday'],
      friday: map['friday'],
      saturday: map['saturday'],
      sunday: map['sunday'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Workinghrsperday.fromJson(String source) =>
      Workinghrsperday.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Workinghrsperday(monday: $monday, tuesday: $tuesday, wednesday: $wednesday, thursday: $thursday, friday: $friday, saturday: $saturday, sunday: $sunday)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Workinghrsperday &&
        o.monday == monday &&
        o.tuesday == tuesday &&
        o.wednesday == wednesday &&
        o.thursday == thursday &&
        o.friday == friday &&
        o.saturday == saturday &&
        o.sunday == sunday;
  }

  @override
  int get hashCode {
    return monday.hashCode ^
        tuesday.hashCode ^
        wednesday.hashCode ^
        thursday.hashCode ^
        friday.hashCode ^
        saturday.hashCode ^
        sunday.hashCode;
  }
}
