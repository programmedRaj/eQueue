import 'dart:convert';

class BizDets {
  String? acn;
  String? acnum;
  String? bname;
  String? descr;
  String? earned;
  String? id;
  String? ifsc;
  String? moneyearned;
  String? name;
  String? profileurl;
  String? type;
  BizDets({
    this.acn,
    this.acnum,
    this.bname,
    this.descr,
    this.earned,
    this.id,
    this.ifsc,
    this.moneyearned,
    this.name,
    this.profileurl,
    this.type,
  });

  BizDets copyWith({
    String? acn,
    String? acnum,
    String? bname,
    String? descr,
    String? earned,
    String? id,
    String? ifsc,
    String? moneyearned,
    String? name,
    String? profileurl,
    String? type,
  }) {
    return BizDets(
      acn: acn ?? this.acn,
      acnum: acnum ?? this.acnum,
      bname: bname ?? this.bname,
      descr: descr ?? this.descr,
      earned: earned ?? this.earned,
      id: id ?? this.id,
      ifsc: ifsc ?? this.ifsc,
      moneyearned: moneyearned ?? this.moneyearned,
      name: name ?? this.name,
      profileurl: profileurl ?? this.profileurl,
      type: type ?? this.type,
    );
  }

  BizDets merge(BizDets model) {
    return BizDets(
      acn: model.acn ?? this.acn,
      acnum: model.acnum ?? this.acnum,
      bname: model.bname ?? this.bname,
      descr: model.descr ?? this.descr,
      earned: model.earned ?? this.earned,
      id: model.id ?? this.id,
      ifsc: model.ifsc ?? this.ifsc,
      moneyearned: model.moneyearned ?? this.moneyearned,
      name: model.name ?? this.name,
      profileurl: model.profileurl ?? this.profileurl,
      type: model.type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'acn': acn,
      'acnum': acnum,
      'bname': bname,
      'descr': descr,
      'earned': earned,
      'id': id,
      'ifsc': ifsc,
      'moneyearned': moneyearned,
      'name': name,
      'profileurl': profileurl,
      'type': type,
    };
  }

  factory BizDets.fromMap(Map<String, dynamic>? map) {
    if (map == null) return BizDets();

    return BizDets(
      acn: map['acn'],
      acnum: map['acnum'],
      bname: map['bname'],
      descr: map['descr'],
      earned: map['earned'],
      id: map['id'],
      ifsc: map['ifsc'],
      moneyearned: map['moneyearned'],
      name: map['name'],
      profileurl: map['profileurl'],
      type: map['type'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BizDets.fromJson(String source) =>
      BizDets.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BizDets(acn: $acn, acnum: $acnum, bname: $bname, descr: $descr, earned: $earned, id: $id, ifsc: $ifsc, moneyearned: $moneyearned, name: $name, profileurl: $profileurl, type: $type)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is BizDets &&
        o.acn == acn &&
        o.acnum == acnum &&
        o.bname == bname &&
        o.descr == descr &&
        o.earned == earned &&
        o.id == id &&
        o.ifsc == ifsc &&
        o.moneyearned == moneyearned &&
        o.name == name &&
        o.profileurl == profileurl &&
        o.type == type;
  }

  @override
  int get hashCode {
    return acn.hashCode ^
        acnum.hashCode ^
        bname.hashCode ^
        descr.hashCode ^
        earned.hashCode ^
        id.hashCode ^
        ifsc.hashCode ^
        moneyearned.hashCode ^
        name.hashCode ^
        profileurl.hashCode ^
        type.hashCode;
  }
}
