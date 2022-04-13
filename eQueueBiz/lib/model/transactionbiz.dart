import 'dart:convert';

class Transbiz {
  final String? status;
  final String? amount;
  final String? txnid;
  final String? userid;
  Transbiz({
    this.status,
    this.amount,
    this.txnid,
    this.userid,
  });

  Transbiz copyWith({
    String? status,
    String? amount,
    String? txnid,
    String? userid,
  }) {
    return Transbiz(
      status: status ?? this.status,
      amount: amount ?? this.amount,
      txnid: txnid ?? this.txnid,
      userid: userid ?? this.userid,
    );
  }

  Transbiz merge(Transbiz model) {
    return Transbiz(
      status: model.status ?? this.status,
      amount: model.amount ?? this.amount,
      txnid: model.txnid ?? this.txnid,
      userid: model.userid ?? this.userid,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'amount': amount,
      'txnid': txnid,
      'userid': userid,
    };
  }

  factory Transbiz.fromMap(Map<String, dynamic>? map) {
    if (map == null) return Transbiz();

    return Transbiz(
      status: map['status'],
      amount: map['amount'],
      txnid: map['txnid'],
      userid: map['userid'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Transbiz.fromJson(String source) =>
      Transbiz.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Transbiz(status: $status, amount: $amount, txnid: $txnid, userid: $userid)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Transbiz &&
        o.status == status &&
        o.amount == amount &&
        o.txnid == txnid &&
        o.userid == userid;
  }

  @override
  int get hashCode {
    return status.hashCode ^ amount.hashCode ^ txnid.hashCode ^ userid.hashCode;
  }
}
