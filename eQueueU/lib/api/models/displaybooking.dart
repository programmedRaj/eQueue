import 'dart:convert';

class DisplayBookings {
  final String bookings;
  final String branchtable;
  final String createdon;
  final String status;
  final String userid;
  final String employeeid;
  final String slots;
  final String comp;
  DisplayBookings({
    this.bookings,
    this.branchtable,
    this.createdon,
    this.status,
    this.userid,
    this.employeeid,
    this.slots,
    this.comp,
  });

  DisplayBookings copyWith({
    String bookings,
    String branchtable,
    String createdon,
    String status,
    String userid,
    String employeeid,
    String slots,
    String comp,
  }) {
    return DisplayBookings(
      bookings: bookings ?? this.bookings,
      branchtable: branchtable ?? this.branchtable,
      createdon: createdon ?? this.createdon,
      status: status ?? this.status,
      userid: userid ?? this.userid,
      employeeid: employeeid ?? this.employeeid,
      slots: slots ?? this.slots,
      comp: comp ?? this.comp,
    );
  }

  DisplayBookings merge(DisplayBookings model) {
    return DisplayBookings(
      bookings: model.bookings ?? this.bookings,
      branchtable: model.branchtable ?? this.branchtable,
      createdon: model.createdon ?? this.createdon,
      status: model.status ?? this.status,
      userid: model.userid ?? this.userid,
      employeeid: model.employeeid ?? this.employeeid,
      slots: model.slots ?? this.slots,
      comp: model.comp ?? this.comp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'bookings': bookings,
      'branchtable': branchtable,
      'createdon': createdon,
      'status': status,
      'userid': userid,
      'employeeid': employeeid,
      'slots': slots,
      'comp': comp,
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
      employeeid: map['employeeid'],
      slots: map['slots'],
      comp: map['comp'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DisplayBookings.fromJson(String source) =>
      DisplayBookings.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DisplayBookings(bookings: $bookings, branchtable: $branchtable, createdon: $createdon, status: $status, userid: $userid, employeeid: $employeeid, slots: $slots, comp: $comp)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DisplayBookings &&
        o.bookings == bookings &&
        o.branchtable == branchtable &&
        o.createdon == createdon &&
        o.status == status &&
        o.userid == userid &&
        o.employeeid == employeeid &&
        o.slots == slots &&
        o.comp == comp;
  }

  @override
  int get hashCode {
    return bookings.hashCode ^
        branchtable.hashCode ^
        createdon.hashCode ^
        status.hashCode ^
        userid.hashCode ^
        employeeid.hashCode ^
        slots.hashCode ^
        comp.hashCode;
  }
}
