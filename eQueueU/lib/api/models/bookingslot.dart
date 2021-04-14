import 'dart:convert';

class BookingSlot {
  String date;
  String time;
  BookingSlot({
    this.date,
    this.time,
  });

  BookingSlot copyWith({
    String date,
    String time,
  }) {
    return BookingSlot(
      date: date ?? this.date,
      time: time ?? this.time,
    );
  }

  BookingSlot merge(BookingSlot model) {
    return BookingSlot(
      date: model.date ?? this.date,
      time: model.time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'time': time,
    };
  }

  factory BookingSlot.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return BookingSlot(
      date: map['date'],
      time: map['time'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingSlot.fromJson(String source) =>
      BookingSlot.fromMap(json.decode(source));

  @override
  String toString() => 'BookingSlot(date: $date, time: $time)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is BookingSlot && o.date == date && o.time == time;
  }

  @override
  int get hashCode => date.hashCode ^ time.hashCode;
}
