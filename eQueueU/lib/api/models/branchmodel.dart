import 'dart:convert';

class BranchModel {
  int? id;
  int? companyid;
  String? address1;
  String? address2;
  String? bname;
  String? bdesc;
  String? bookingperday;
  String? city;
  String? countercount;
  String? department;
  String? geolocation;
  String? moneyearned;
  String? notifytime;
  String? perdayhours;
  String? phonenumber;
  String? postalcode;
  String? profilephotourl;
  String? province;
  String? services;
  String? threshold;
  String? timezone;
  String? workinghours;
  BranchModel(
      {this.id,
      this.companyid,
      this.address1,
      this.address2,
      this.bname,
      this.bookingperday,
      this.city,
      this.countercount,
      this.department,
      this.geolocation,
      this.moneyearned,
      this.notifytime,
      this.perdayhours,
      this.phonenumber,
      this.postalcode,
      this.profilephotourl,
      this.province,
      this.services,
      this.threshold,
      this.timezone,
      this.workinghours,
      this.bdesc});

  BranchModel copyWith({
    int? id,
    int? companyid,
    String? address1,
    String? address2,
    String? bname,
    String? bookingperday,
    String? city,
    String? countercount,
    String? department,
    String? geolocation,
    String? moneyearned,
    String? notifytime,
    String? perdayhours,
    String? phonenumber,
    String? postalcode,
    String? profilephotourl,
    String? province,
    String? services,
    String? threshold,
    String? timezone,
    String? workinghours,
  }) {
    return BranchModel(
      id: id ?? this.id,
      companyid: companyid ?? this.companyid,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      bname: bname ?? this.bname,
      bookingperday: bookingperday ?? this.bookingperday,
      city: city ?? this.city,
      countercount: countercount ?? this.countercount,
      department: department ?? this.department,
      geolocation: geolocation ?? this.geolocation,
      moneyearned: moneyearned ?? this.moneyearned,
      notifytime: notifytime ?? this.notifytime,
      perdayhours: perdayhours ?? this.perdayhours,
      phonenumber: phonenumber ?? this.phonenumber,
      postalcode: postalcode ?? this.postalcode,
      profilephotourl: profilephotourl ?? this.profilephotourl,
      province: province ?? this.province,
      services: services ?? this.services,
      threshold: threshold ?? this.threshold,
      timezone: timezone ?? this.timezone,
      workinghours: workinghours ?? this.workinghours,
    );
  }

  BranchModel merge(BranchModel model) {
    return BranchModel(
      id: model.id ?? this.id,
      companyid: model.companyid ?? this.companyid,
      address1: model.address1 ?? this.address1,
      address2: model.address2 ?? this.address2,
      bname: model.bname ?? this.bname,
      bookingperday: model.bookingperday ?? this.bookingperday,
      city: model.city ?? this.city,
      countercount: model.countercount ?? this.countercount,
      department: model.department ?? this.department,
      geolocation: model.geolocation ?? this.geolocation,
      moneyearned: model.moneyearned ?? this.moneyearned,
      notifytime: model.notifytime ?? this.notifytime,
      perdayhours: model.perdayhours ?? this.perdayhours,
      phonenumber: model.phonenumber ?? this.phonenumber,
      postalcode: model.postalcode ?? this.postalcode,
      profilephotourl: model.profilephotourl ?? this.profilephotourl,
      province: model.province ?? this.province,
      services: model.services ?? this.services,
      threshold: model.threshold ?? this.threshold,
      timezone: model.timezone ?? this.timezone,
      workinghours: model.workinghours ?? this.workinghours,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'companyid': companyid,
      'address1': address1,
      'address2': address2,
      'bname': bname,
      'bdescription': bdesc,
      'bookingperday': bookingperday,
      'city': city,
      'countercount': countercount,
      'department': department,
      'geolocation': geolocation,
      'moneyearned': moneyearned,
      'notifytime': notifytime,
      'perdayhours': perdayhours,
      'phonenumber': phonenumber,
      'postalcode': postalcode,
      'profilephotourl': profilephotourl,
      'province': province,
      'services': services,
      'threshold': threshold,
      'timezone': timezone,
      'workinghours': workinghours,
    };
  }

  factory BranchModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) return BranchModel();

    return BranchModel(
      id: map['id'],
      companyid: map['companyid'],
      address1: map['address1'],
      address2: map['address2'],
      bname: map['bname'],
      bdesc: map['bdescription'],
      bookingperday: map['bookingperday'],
      city: map['city'],
      countercount: map['countercount'],
      department: map['department'],
      geolocation: map['geolocation'],
      moneyearned: map['moneyearned'],
      notifytime: map['notifytime'],
      perdayhours: map['perdayhours'],
      phonenumber: map['phonenumber'],
      postalcode: map['postalcode'],
      profilephotourl: map['profilephotourl'],
      province: map['province'],
      services: map['services'],
      threshold: map['threshold'],
      timezone: map['timezone'],
      workinghours: map['workinghours'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BranchModel.fromJson(String source) =>
      BranchModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BranchModel(id: $id, companyid: $companyid, address1: $address1, address2: $address2, bname: $bname, bookingperday: $bookingperday, city: $city, countercount: $countercount, department: $department, geolocation: $geolocation, moneyearned: $moneyearned, notifytime: $notifytime, perdayhours: $perdayhours, phonenumber: $phonenumber, postalcode: $postalcode, profilephotourl: $profilephotourl, province: $province, services: $services, threshold: $threshold, timezone: $timezone, workinghours: $workinghours)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is BranchModel &&
        o.id == id &&
        o.companyid == companyid &&
        o.address1 == address1 &&
        o.address2 == address2 &&
        o.bname == bname &&
        o.bookingperday == bookingperday &&
        o.city == city &&
        o.countercount == countercount &&
        o.department == department &&
        o.geolocation == geolocation &&
        o.moneyearned == moneyearned &&
        o.notifytime == notifytime &&
        o.perdayhours == perdayhours &&
        o.phonenumber == phonenumber &&
        o.postalcode == postalcode &&
        o.profilephotourl == profilephotourl &&
        o.province == province &&
        o.services == services &&
        o.threshold == threshold &&
        o.timezone == timezone &&
        o.workinghours == workinghours;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        companyid.hashCode ^
        address1.hashCode ^
        address2.hashCode ^
        bname.hashCode ^
        bookingperday.hashCode ^
        city.hashCode ^
        countercount.hashCode ^
        department.hashCode ^
        geolocation.hashCode ^
        moneyearned.hashCode ^
        notifytime.hashCode ^
        perdayhours.hashCode ^
        phonenumber.hashCode ^
        postalcode.hashCode ^
        profilephotourl.hashCode ^
        province.hashCode ^
        services.hashCode ^
        threshold.hashCode ^
        timezone.hashCode ^
        workinghours.hashCode;
  }
}
