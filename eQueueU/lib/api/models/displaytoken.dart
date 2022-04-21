import 'dart:convert';

class DisplayToken {
  final String? token;
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
  DisplayToken({
    this.token,
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

  DisplayToken copyWith({
    String? token,
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
    return DisplayToken(
      token: token ?? this.token,
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

  DisplayToken merge(DisplayToken model) {
    return DisplayToken(
      token: model.token ?? this.token,
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
      'token': token,
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

  factory DisplayToken.fromMap(Map<String, dynamic>? map) {
    if (map == null) return DisplayToken();

    return DisplayToken(
      token: map['token'],
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

  factory DisplayToken.fromJson(String source) =>
      DisplayToken.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DisplayToken(token: $token, branchtable: $branchtable, createdon: $createdon, status: $status, userid: $userid, employeeid: $employeeid, slots: $slots, comp: $comp, empr: $empr, countnum: $countnum, waitlist: $waitlist)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DisplayToken &&
        o.token == token &&
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
    return token.hashCode ^
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
