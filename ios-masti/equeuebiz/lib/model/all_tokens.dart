import 'dart:convert';

class TokenAll {
  String branchid;
  String counterno;
  String createtime;
  String department;
  String devicetoken;
  String employeeid;
  String id;
  String insurance;
  String slots;
  String status;
  String userid;
  TokenAll({
    this.branchid,
    this.counterno,
    this.createtime,
    this.department,
    this.devicetoken,
    this.employeeid,
    this.id,
    this.insurance,
    this.slots,
    this.status,
    this.userid,
  });

  TokenAll copyWith({
    String branchid,
    String counterno,
    String createtime,
    String department,
    String devicetoken,
    String employeeid,
    String id,
    String insurance,
    String slots,
    String status,
    String userid,
  }) {
    return TokenAll(
      branchid: branchid ?? this.branchid,
      counterno: counterno ?? this.counterno,
      createtime: createtime ?? this.createtime,
      department: department ?? this.department,
      devicetoken: devicetoken ?? this.devicetoken,
      employeeid: employeeid ?? this.employeeid,
      id: id ?? this.id,
      insurance: insurance ?? this.insurance,
      slots: slots ?? this.slots,
      status: status ?? this.status,
      userid: userid ?? this.userid,
    );
  }

  TokenAll merge(TokenAll model) {
    return TokenAll(
      branchid: model.branchid ?? this.branchid,
      counterno: model.counterno ?? this.counterno,
      createtime: model.createtime ?? this.createtime,
      department: model.department ?? this.department,
      devicetoken: model.devicetoken ?? this.devicetoken,
      employeeid: model.employeeid ?? this.employeeid,
      id: model.id ?? this.id,
      insurance: model.insurance ?? this.insurance,
      slots: model.slots ?? this.slots,
      status: model.status ?? this.status,
      userid: model.userid ?? this.userid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'branchid': branchid,
      'counterno': counterno,
      'createtime': createtime,
      'department': department,
      'devicetoken': devicetoken,
      'employeeid': employeeid,
      'id': id,
      'insurance': insurance,
      'slots': slots,
      'status': status,
      'userid': userid,
    };
  }

  factory TokenAll.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return TokenAll(
      branchid: map['branchid'],
      counterno: map['counterno'],
      createtime: map['createtime'],
      department: map['department'],
      devicetoken: map['devicetoken'],
      employeeid: map['employeeid'],
      id: map['id'],
      insurance: map['insurance'],
      slots: map['slots'],
      status: map['status'],
      userid: map['userid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TokenAll.fromJson(String source) => TokenAll.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TokenAll(branchid: $branchid, counterno: $counterno, createtime: $createtime, department: $department, devicetoken: $devicetoken, employeeid: $employeeid, id: $id, insurance: $insurance, slots: $slots, status: $status, userid: $userid)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is TokenAll &&
      o.branchid == branchid &&
      o.counterno == counterno &&
      o.createtime == createtime &&
      o.department == department &&
      o.devicetoken == devicetoken &&
      o.employeeid == employeeid &&
      o.id == id &&
      o.insurance == insurance &&
      o.slots == slots &&
      o.status == status &&
      o.userid == userid;
  }

  @override
  int get hashCode {
    return branchid.hashCode ^
      counterno.hashCode ^
      createtime.hashCode ^
      department.hashCode ^
      devicetoken.hashCode ^
      employeeid.hashCode ^
      id.hashCode ^
      insurance.hashCode ^
      slots.hashCode ^
      status.hashCode ^
      userid.hashCode;
  }
}
