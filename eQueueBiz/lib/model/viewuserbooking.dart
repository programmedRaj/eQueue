import 'dart:convert';

class ViewUserBooking {
  final String? add1;
  final String? add2;
  final String? city;
  final String? province;
  final String? name;
  final String? phone;
  final String? postal;
  final String? profileimg;
  final String? id;
  ViewUserBooking({
    this.add1,
    this.add2,
    this.city,
    this.province,
    this.name,
    this.phone,
    this.postal,
    this.profileimg,
    this.id,
  });

  ViewUserBooking copyWith({
    String? add1,
    String? add2,
    String? city,
    String? province,
    String? name,
    String? phone,
    String? postal,
    String? profileimg,
    String? id,
  }) {
    return ViewUserBooking(
      add1: add1 ?? this.add1,
      add2: add2 ?? this.add2,
      city: city ?? this.city,
      province: province ?? this.province,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      postal: postal ?? this.postal,
      profileimg: profileimg ?? this.profileimg,
      id: id ?? this.id,
    );
  }

  ViewUserBooking merge(ViewUserBooking model) {
    return ViewUserBooking(
      add1: model.add1 ?? this.add1,
      add2: model.add2 ?? this.add2,
      city: model.city ?? this.city,
      province: model.province ?? this.province,
      name: model.name ?? this.name,
      phone: model.phone ?? this.phone,
      postal: model.postal ?? this.postal,
      profileimg: model.profileimg ?? this.profileimg,
      id: model.id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'add1': add1,
      'add2': add2,
      'city': city,
      'province': province,
      'name': name,
      'phone': phone,
      'postal': postal,
      'profileimg': profileimg,
      'id': id,
    };
  }

  factory ViewUserBooking.fromMap(Map<String, dynamic>? map) {
    if (map == null) return ViewUserBooking();

    return ViewUserBooking(
      add1: map['add1'],
      add2: map['add2'],
      city: map['city'],
      province: map['province'],
      name: map['name'],
      phone: map['phone'],
      postal: map['postal'],
      profileimg: map['profileimg'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ViewUserBooking.fromJson(String source) =>
      ViewUserBooking.fromMap(json.decode(source));

  @override
  String toString() {
    return 'ViewUserBooking(add1: $add1, add2: $add2, city: $city, province: $province, name: $name, phone: $phone, postal: $postal, profileimg: $profileimg, id: $id)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ViewUserBooking &&
        o.add1 == add1 &&
        o.add2 == add2 &&
        o.city == city &&
        o.province == province &&
        o.name == name &&
        o.phone == phone &&
        o.postal == postal &&
        o.profileimg == profileimg &&
        o.id == id;
  }

  @override
  int get hashCode {
    return add1.hashCode ^
        add2.hashCode ^
        city.hashCode ^
        province.hashCode ^
        name.hashCode ^
        phone.hashCode ^
        postal.hashCode ^
        profileimg.hashCode ^
        id.hashCode;
  }
}
