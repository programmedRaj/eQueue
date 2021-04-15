import 'dart:convert';

class DisplayBookings {
  final String bookings;
  final String branchtable;
  final String createdon;
  final String status;
  final String userid;
  DisplayBookings({
    this.bookings,
    this.branchtable,
    this.createdon,
    this.status,
    this.userid,
  });

  DisplayBookings copyWith({
    String bookings,
    String branchtable,
    String createdon,
    String status,
    String userid,
  }) {
    return DisplayBookings(
      bookings: bookings ?? this.bookings,
      branchtable: branchtable ?? this.branchtable,
      createdon: createdon ?? this.createdon,
      status: status ?? this.status,
      userid: userid ?? this.userid,
    );
  }

  DisplayBookings merge(DisplayBookings model) {
    return DisplayBookings(
      bookings: model.bookings ?? this.bookings,
      branchtable: model.branchtable ?? this.branchtable,
      createdon: model.createdon ?? this.createdon,
      status: model.status ?? this.status,
      userid: model.userid ?? this.userid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bookings': bookings,
      'branchtable': branchtable,
      'createdon': createdon,
      'status': status,
      'userid': userid,
    };
  }

  factory DisplayBookings.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DisplayBookings(
      bookings: map['bookings'],
      branchtable: map['branchtable'],
      createdon: map['createdon'],
      status: map['status'],
      userid: map['userid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DisplayBookings.fromJson(String source) =>
      DisplayBookings.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DisplayBookings(bookings: $bookings, branchtable: $branchtable, createdon: $createdon, status: $status, userid: $userid)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DisplayBookings &&
        o.bookings == bookings &&
        o.branchtable == branchtable &&
        o.createdon == createdon &&
        o.status == status &&
        o.userid == userid;
  }

  @override
  int get hashCode {
    return bookings.hashCode ^
        branchtable.hashCode ^
        createdon.hashCode ^
        status.hashCode ^
        userid.hashCode;
  }
}
