import 'dart:convert';

class CompanyModel {
  String? acname;
  String? acnum;
  String? bankname;
  String? descr;
  String? earnedtilldate;
  int? id;
  String? ifsc;
  String? moneyearned;
  String? name;
  String? onliner;
  String? profileurl;
  String? type;
  String? insurance;
  int? paidrank;
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
    this.insurance,
    this.paidrank,
  });

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
      'insurance': insurance,
      "paidrank": paidrank
    };
  }

  factory CompanyModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) return CompanyModel();

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
        insurance: map['insurance'],
        paidrank: map['paidrank']);
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
        o.type == type &&
        o.paidrank == paidrank &&
        o.insurance == insurance;
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
        type.hashCode ^
        paidrank.hashCode ^
        insurance.hashCode;
  }
}
