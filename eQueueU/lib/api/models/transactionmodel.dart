import 'dart:convert';

class TransactionModel {
  String? amount;
  String? color;
  String? status;
  int? tid;
  int? uid;
  TransactionModel({
    this.amount,
    this.color,
    this.status,
    this.tid,
    this.uid,
  });

  TransactionModel copyWith({
    String? amount,
    String? color,
    String? status,
    int? tid,
    int? uid,
  }) {
    return TransactionModel(
      amount: amount ?? this.amount,
      color: color ?? this.color,
      status: status ?? this.status,
      tid: tid ?? this.tid,
      uid: uid ?? this.uid,
    );
  }

  TransactionModel merge(TransactionModel model) {
    return TransactionModel(
      amount: model.amount ?? this.amount,
      color: model.color ?? this.color,
      status: model.status ?? this.status,
      tid: model.tid ?? this.tid,
      uid: model.uid ?? this.uid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'color': color,
      'status': status,
      'tid': tid,
      'uid': uid,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic>? map) {
    if (map == null) return TransactionModel();

    return TransactionModel(
      amount: map['amount'],
      color: map['color'],
      status: map['status'],
      tid: map['tid'],
      uid: map['uid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory TransactionModel.fromJson(String source) =>
      TransactionModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'TransactionModel(amount: $amount, color: $color, status: $status, tid: $tid, uid: $uid)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is TransactionModel &&
        o.amount == amount &&
        o.color == color &&
        o.status == status &&
        o.tid == tid &&
        o.uid == uid;
  }

  @override
  int get hashCode {
    return amount.hashCode ^
        color.hashCode ^
        status.hashCode ^
        tid.hashCode ^
        uid.hashCode;
  }
}
