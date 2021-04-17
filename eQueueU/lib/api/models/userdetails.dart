import 'dart:convert';

class UserDets {
  String name;
  String profileurl;
  String address1;
  String address2;
  String province;
  String city;
  String postalcode;
  String money;
  String bonus;
  String phone;
  UserDets({
    this.name,
    this.profileurl,
    this.address1,
    this.address2,
    this.province,
    this.city,
    this.postalcode,
    this.money,
    this.bonus,
    this.phone,
  });

  UserDets copyWith({
    String name,
    String profileurl,
    String address1,
    String address2,
    String province,
    String city,
    String postalcode,
    String money,
    String bonus,
    String phone,
  }) {
    return UserDets(
      name: name ?? this.name,
      profileurl: profileurl ?? this.profileurl,
      address1: address1 ?? this.address1,
      address2: address2 ?? this.address2,
      province: province ?? this.province,
      city: city ?? this.city,
      postalcode: postalcode ?? this.postalcode,
      money: money ?? this.money,
      bonus: bonus ?? this.bonus,
      phone: phone ?? this.phone,
    );
  }

  UserDets merge(UserDets model) {
    return UserDets(
      name: model.name ?? this.name,
      profileurl: model.profileurl ?? this.profileurl,
      address1: model.address1 ?? this.address1,
      address2: model.address2 ?? this.address2,
      province: model.province ?? this.province,
      city: model.city ?? this.city,
      postalcode: model.postalcode ?? this.postalcode,
      money: model.money ?? this.money,
      bonus: model.bonus ?? this.bonus,
      phone: model.phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'profileurl': profileurl,
      'address1': address1,
      'address2': address2,
      'province': province,
      'city': city,
      'postalcode': postalcode,
      'money': money,
      'bonus': bonus,
      'phone': phone,
    };
  }

  factory UserDets.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return UserDets(
      name: map['name'],
      profileurl: map['profileurl'],
      address1: map['address1'],
      address2: map['address2'],
      province: map['province'],
      city: map['city'],
      postalcode: map['postalcode'],
      money: map['money'],
      bonus: map['bonus'],
      phone: map['phone'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDets.fromJson(String source) =>
      UserDets.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserDets(name: $name, profileurl: $profileurl, address1: $address1, address2: $address2, province: $province, city: $city, postalcode: $postalcode, money: $money, bonus: $bonus, phone: $phone)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is UserDets &&
        o.name == name &&
        o.profileurl == profileurl &&
        o.address1 == address1 &&
        o.address2 == address2 &&
        o.province == province &&
        o.city == city &&
        o.postalcode == postalcode &&
        o.money == money &&
        o.bonus == bonus &&
        o.phone == phone;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        profileurl.hashCode ^
        address1.hashCode ^
        address2.hashCode ^
        province.hashCode ^
        city.hashCode ^
        postalcode.hashCode ^
        money.hashCode ^
        bonus.hashCode ^
        phone.hashCode;
  }
}
