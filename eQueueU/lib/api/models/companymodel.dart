import 'dart:convert';

class CompanyModel {
  String acname;
  String acnum;
  String bankname;
  String descr;
  String earnedtilldate;
  int id;
  String ifsc;
  String moneyearned;
  String name;
  String onliner;
  String profileurl;
  String type;
  CompanyModel({
    this.acname,
    this.acnum,
    this.bankname,
    this.descr,
    this.earnedtilldate,
    this.id,
    this.ifsc,
    this.moneyearned,
    this.name,
    this.onliner,
    this.profileurl,
    this.type,
  });

  CompanyModel copyWith({
    String acname,
    String acnum,
    String bankname,
    String descr,
    String earnedtilldate,
    int id,
    String ifsc,
    String moneyearned,
    String name,
    String onliner,
    String profileurl,
    String type,
  }) {
    return CompanyModel(
      acname: acname ?? this.acname,
      acnum: acnum ?? this.acnum,
      bankname: bankname ?? this.bankname,
      descr: descr ?? this.descr,
      earnedtilldate: earnedtilldate ?? this.earnedtilldate,
      id: id ?? this.id,
      ifsc: ifsc ?? this.ifsc,
      moneyearned: moneyearned ?? this.moneyearned,
      name: name ?? this.name,
      onliner: onliner ?? this.onliner,
      profileurl: profileurl ?? this.profileurl,
      type: type ?? this.type,
    );
  }

  CompanyModel merge(CompanyModel model) {
    return CompanyModel(
      acname: model.acname ?? this.acname,
      acnum: model.acnum ?? this.acnum,
      bankname: model.bankname ?? this.bankname,
      descr: model.descr ?? this.descr,
      earnedtilldate: model.earnedtilldate ?? this.earnedtilldate,
      id: model.id ?? this.id,
      ifsc: model.ifsc ?? this.ifsc,
      moneyearned: model.moneyearned ?? this.moneyearned,
      name: model.name ?? this.name,
      onliner: model.onliner ?? this.onliner,
      profileurl: model.profileurl ?? this.profileurl,
      type: model.type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'acname': acname,
      'acnum': acnum,
      'bankname': bankname,
      'descr': descr,
      'earnedtilldate': earnedtilldate,
      'id': id,
      'ifsc': ifsc,
      'moneyearned': moneyearned,
      'name': name,
      'onliner': onliner,
      'profileurl': profileurl,
      'type': type,
    };
  }

  factory CompanyModel.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CompanyModel(
      acname: map['acname'],
      acnum: map['acnum'],
      bankname: map['bankname'],
      descr: map['descr'],
      earnedtilldate: map['earnedtilldate'],
      id: map['id'],
      ifsc: map['ifsc'],
      moneyearned: map['moneyearned'],
      name: map['name'],
      onliner: map['onliner'],
      profileurl: map['profileurl'],
      type: map['type'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CompanyModel.fromJson(String source) =>
      CompanyModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CompanyModel(acname: $acname, acnum: $acnum, bankname: $bankname, descr: $descr, earnedtilldate: $earnedtilldate, id: $id, ifsc: $ifsc, moneyearned: $moneyearned, name: $name, onliner: $onliner, profileurl: $profileurl, type: $type)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CompanyModel &&
        o.acname == acname &&
        o.acnum == acnum &&
        o.bankname == bankname &&
        o.descr == descr &&
        o.earnedtilldate == earnedtilldate &&
        o.id == id &&
        o.ifsc == ifsc &&
        o.moneyearned == moneyearned &&
        o.name == name &&
        o.onliner == onliner &&
        o.profileurl == profileurl &&
        o.type == type;
  }

  @override
  int get hashCode {
    return acname.hashCode ^
        acnum.hashCode ^
        bankname.hashCode ^
        descr.hashCode ^
        earnedtilldate.hashCode ^
        id.hashCode ^
        ifsc.hashCode ^
        moneyearned.hashCode ^
        name.hashCode ^
        onliner.hashCode ^
        profileurl.hashCode ^
        type.hashCode;
  }
}
