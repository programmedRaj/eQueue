import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:equeuebiz/constants/api_constant.dart';
import 'package:equeuebiz/model/bookinh_model.dart';
import 'package:equeuebiz/model/branch_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookingDet with ChangeNotifier {
  getbookdets(String bid, String bname, String date, String token) async {
    var map = new Map<String, dynamic>();
    map['branch_id'] = bid.toString();
    map['branch_name'] = bname.toString();
    map['date_sort'] = date.toString();

    var response = await retry(
      () => http
          .post(Uri.parse(BookingApi.bookingdetails),
              headers: {"Authorization": token}, body: map)
          .timeout(Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    var k = response.body;
    var n = json.decode(k);
    print(n['bookings'][0]['branch_id']);

    removebook();
    if (n['bookings'].length > 0)
      for (int i = 0; i < n['bookings'].length; i++) {
        addbms(
          branchid: n['bookings'][i]['branch_id'],
          counter: n['bookings'][i]['counter_number'],
          createtime: n['bookings'][i]['create_time'],
          department: n['bookings'][i]['department'],
          devicetoken: n['bookings'][i]['device_token'],
          employeeid: n['bookings'][i]['employee_id'],
          id: n['bookings'][i]['id'],
          insurance: n['bookings'][i]['insurance'],
          slots: n['bookings'][i]['slots'],
          status: n['bookings'][i]['status'],
          userid: n['bookings'][i]['user_id'],
        );
      }
  }

  List<BookingModel> bm = [];

  List<BookingModel> get bms => bm;

  void addbms({
    String branchid,
    String counter,
    String createtime,
    String department,
    String devicetoken,
    String id,
    String insurance,
    String slots,
    String status,
    String userid,
    String employeeid,
  }) {
    bms.add(BookingModel(
      branchid: branchid,
      counter: counter,
      createtime: createtime,
      department: department,
      devicetoken: devicetoken,
      employeeid: employeeid,
      id: id,
      insurance: insurance,
      slots: slots,
      status: status,
      userid: userid,
    ));
    notifyListeners();
  }

  void removebook() {
    bms.clear();
    notifyListeners();
  }
}
