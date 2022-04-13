import 'dart:convert';

class BookingModel {
  String? branchid;
  String? counter;
  String? createtime;
  String? department;
  String? devicetoken;
  String? id;
  String? insurance;
  String? slots;
  String? status;
  String? userid;
  String? employeeid;
  BookingModel({
    this.branchid,
    this.counter,
    this.createtime,
    this.department,
    this.devicetoken,
    this.id,
    this.insurance,
    this.slots,
    this.status,
    this.userid,
    this.employeeid,
  });

  BookingModel copyWith({
    String? branchid,
    String? counter,
    String? createtime,
    String? department,
    String? devicetoken,
    String? id,
    String? insurance,
    String? slots,
    String? status,
    String? userid,
    String? employeeid,
  }) {
    return BookingModel(
      branchid: branchid ?? this.branchid,
      counter: counter ?? this.counter,
      createtime: createtime ?? this.createtime,
      department: department ?? this.department,
      devicetoken: devicetoken ?? this.devicetoken,
      id: id ?? this.id,
      insurance: insurance ?? this.insurance,
      slots: slots ?? this.slots,
      status: status ?? this.status,
      userid: userid ?? this.userid,
      employeeid: employeeid ?? this.employeeid,
    );
  }

  BookingModel merge(BookingModel model) {
    return BookingModel(
      branchid: model.branchid ?? this.branchid,
      counter: model.counter ?? this.counter,
      createtime: model.createtime ?? this.createtime,
      department: model.department ?? this.department,
      devicetoken: model.devicetoken ?? this.devicetoken,
      id: model.id ?? this.id,
      insurance: model.insurance ?? this.insurance,
      slots: model.slots ?? this.slots,
      status: model.status ?? this.status,
      userid: model.userid ?? this.userid,
      employeeid: model.employeeid ?? this.employeeid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'branchid': branchid,
      'counter': counter,
      'createtime': createtime,
      'department': department,
      'devicetoken': devicetoken,
      'id': id,
      'insurance': insurance,
      'slots': slots,
      'status': status,
      'userid': userid,
      'employeeid': employeeid,
    };
  }

  factory BookingModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) return BookingModel();

    return BookingModel(
      branchid: map['branchid'],
      counter: map['counter'],
      createtime: map['createtime'],
      department: map['department'],
      devicetoken: map['devicetoken'],
      id: map['id'],
      insurance: map['insurance'],
      slots: map['slots'],
      status: map['status'],
      userid: map['userid'],
      employeeid: map['employeeid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory BookingModel.fromJson(String source) =>
      BookingModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'BookingModel(branchid: $branchid, counter: $counter, createtime: $createtime, department: $department, devicetoken: $devicetoken, id: $id, insurance: $insurance, slots: $slots, status: $status, userid: $userid, employeeid: $employeeid)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is BookingModel &&
        o.branchid == branchid &&
        o.counter == counter &&
        o.createtime == createtime &&
        o.department == department &&
        o.devicetoken == devicetoken &&
        o.id == id &&
        o.insurance == insurance &&
        o.slots == slots &&
        o.status == status &&
        o.userid == userid &&
        o.employeeid == employeeid;
  }

  @override
  int get hashCode {
    return branchid.hashCode ^
        counter.hashCode ^
        createtime.hashCode ^
        department.hashCode ^
        devicetoken.hashCode ^
        id.hashCode ^
        insurance.hashCode ^
        slots.hashCode ^
        status.hashCode ^
        userid.hashCode ^
        employeeid.hashCode;
  }
}
