import 'dart:convert';

class DisplayToken {
  final String token;
  final String branchtable;
  final String createdon;
  final String status;
  final String userid;
  DisplayToken({
    this.token,
    this.branchtable,
    this.createdon,
    this.status,
    this.userid,
  });

  DisplayToken copyWith({
    String token,
    String branchtable,
    String createdon,
    String status,
    String userid,
  }) {
    return DisplayToken(
      token: token ?? this.token,
      branchtable: branchtable ?? this.branchtable,
      createdon: createdon ?? this.createdon,
      status: status ?? this.status,
      userid: userid ?? this.userid,
    );
  }

  DisplayToken merge(DisplayToken model) {
    return DisplayToken(
      token: model.token ?? this.token,
      branchtable: model.branchtable ?? this.branchtable,
      createdon: model.createdon ?? this.createdon,
      status: model.status ?? this.status,
      userid: model.userid ?? this.userid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'token': token,
      'branchtable': branchtable,
      'createdon': createdon,
      'status': status,
      'userid': userid,
    };
  }

  factory DisplayToken.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DisplayToken(
      token: map['token'],
      branchtable: map['branchtable'],
      createdon: map['createdon'],
      status: map['status'],
      userid: map['userid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DisplayToken.fromJson(String source) =>
      DisplayToken.fromMap(json.decode(source));

  @override
  String toString() {
    return 'DisplayToken(token: $token, branchtable: $branchtable, createdon: $createdon, status: $status, userid: $userid)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DisplayToken &&
        o.token == token &&
        o.branchtable == branchtable &&
        o.createdon == createdon &&
        o.status == status &&
        o.userid == userid;
  }

  @override
  int get hashCode {
    return token.hashCode ^
        branchtable.hashCode ^
        createdon.hashCode ^
        status.hashCode ^
        userid.hashCode;
  }
}
