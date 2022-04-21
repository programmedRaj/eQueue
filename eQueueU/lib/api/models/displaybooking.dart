import 'dart:convert';

class DisplayBookings {
  final String? price;
  final String? bookings;
  final String? branchtable;
  final String? createdon;
  final String? status;
  final String? userid;
  final String? employeeid;
  final String? slots;
  final String? comp;
  final String? empr;
  final String? countnum;
  final String? waitlist;
  DisplayBookings({
    this.price,
    this.bookings,
    this.branchtable,
    this.createdon,
    this.status,
    this.userid,
    this.employeeid,
    this.slots,
    this.comp,
    this.empr,
    this.countnum,
    this.waitlist,
  });

  DisplayBookings copyWith({
    String? price,
    String? bookings,
    String? branchtable,
    String? createdon,
    String? status,
    String? userid,
    String? employeeid,
    String? slots,
    String? comp,
    String? empr,
    String? countnum,
    String? waitlist,
  }) {
    return DisplayBookings(
      price: price ?? this.price,
      bookings: bookings ?? this.bookings,
      branchtable: branchtable ?? this.branchtable,
      createdon: createdon ?? this.createdon,
      status: status ?? this.status,
      userid: userid ?? this.userid,
      employeeid: employeeid ?? this.employeeid,
      slots: slots ?? this.slots,
      comp: comp ?? this.comp,
      empr: empr ?? this.empr,
      countnum: countnum ?? this.countnum,
      waitlist: waitlist ?? this.waitlist,
    );
  }

  DisplayBookings merge(DisplayBookings model) {
    return DisplayBookings(
      price: model.price ?? this.price,
      bookings: model.bookings ?? this.bookings,
      branchtable: model.branchtable ?? this.branchtable,
      createdon: model.createdon ?? this.createdon,
      status: model.status ?? this.status,
      userid: model.userid ?? this.userid,
      employeeid: model.employeeid ?? this.employeeid,
      slots: model.slots ?? this.slots,
      comp: model.comp ?? this.comp,
      empr: model.empr ?? this.empr,
      countnum: model.countnum ?? this.countnum,
      waitlist: model.waitlist ?? this.waitlist,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'price': price,
      'bookings': bookings,
      'branchtable': branchtable,
      'createdon': createdon,
      'status': status,
      'userid': userid,
      'employeeid': employeeid,
      'slots': slots,
      'comp': comp,
      'empr': empr,
      'countnum': countnum,
      'waitlist': waitlist,
    };
  }

  factory DisplayBookings.fromMap(Map<String, dynamic>? map) {
    if (map == null) return DisplayBookings();

    return DisplayBookings(
      price: map['price'],
      bookings: map['bookings'],
      branchtable: map['branchtable'],
      createdon: map['createdon'],
      status: map['status'],
      userid: map['userid'],
      employeeid: map['employeeid'],
      slots: map['slots'],
      comp: map['comp'],
      empr: map['empr'],
      countnum: map['countnum'],
      waitlist: map['waitlist'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DisplayBookings.fromJson(String source) =>
      DisplayBookings.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DisplayBookings(price: $price, bookings: $bookings, branchtable: $branchtable, createdon: $createdon, status: $status, userid: $userid, employeeid: $employeeid, slots: $slots, comp: $comp, empr: $empr, countnum: $countnum, waitlist: $waitlist)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DisplayBookings &&
        o.price == price &&
        o.bookings == bookings &&
        o.branchtable == branchtable &&
        o.createdon == createdon &&
        o.status == status &&
        o.userid == userid &&
        o.employeeid == employeeid &&
        o.slots == slots &&
        o.comp == comp &&
        o.empr == empr &&
        o.countnum == countnum &&
        o.waitlist == waitlist;
  }

  @override
  int get hashCode {
    return price.hashCode ^
        bookings.hashCode ^
        branchtable.hashCode ^
        createdon.hashCode ^
        status.hashCode ^
        userid.hashCode ^
        employeeid.hashCode ^
        slots.hashCode ^
        comp.hashCode ^
        empr.hashCode ^
        countnum.hashCode ^
        waitlist.hashCode;
  }
}
