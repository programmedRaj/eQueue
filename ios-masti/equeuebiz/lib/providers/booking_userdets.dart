import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:equeuebiz/constants/api_constant.dart';
import 'package:equeuebiz/model/viewuserbooking.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:retry/retry.dart';

class BookingDetUserDets with ChangeNotifier {
  getbookdets(String bid, String userid, String token) async {
    print(userid);
    var map = new Map<String, dynamic>();
    map['branch_id'] = bid;
    map['user_id'] = userid;

    var response = await retry(
      () => http
          .post(Uri.parse(BookingApi.viewbookinguserdetails),
              headers: {"Authorization": token}, body: map)
          .timeout(Duration(seconds: 5)),
      retryIf: (e) => e is SocketException || e is TimeoutException,
    );
    var k = response.body;
    var n = json.decode(k);
    var tid = n['transaction_id'];

    print(n);
    removedet();
    adddet(
      add1: n['userdetails']['address1'],
      add2: n['userdetails']['address2'],
      city: n['userdetails']['city'],
      province: n['userdetails']['province'],
      namee: n['userdetails']['name'],
      phone: n['userdetails']['phone_number'],
      profileurl: n['userdetails']['profile_url'],
      postal: n['userdetails']['postalcode'],
      id: n['userdetails']['id'].toString(),
    );
  }

  List<ViewUserBooking> view = [];
  List<ViewUserBooking> get views => view;

  void adddet({
    String add1,
    String add2,
    String city,
    String province,
    String postal,
    String namee,
    String phone,
    String profileurl,
    String id,
  }) {
    views.add(ViewUserBooking(
      add1: add1,
      add2: add2,
      city: city,
      id: id,
      name: namee,
      phone: phone,
      postal: postal,
      profileimg: profileurl,
      province: province,
    ));
    print(views);
    notifyListeners();
  }

  void removedet() {
    views.clear();
    notifyListeners();
  }
}
