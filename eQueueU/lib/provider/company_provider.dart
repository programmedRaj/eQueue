import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:eQueue/api/models/companymodel.dart';
import 'package:eQueue/api/service/baseurl.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CompanyProvider extends ChangeNotifier {
  BaseUrl baseUrl = BaseUrl();

  Future getCompanies(
      {bool sort, String sortby, String ascdsc, String type}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');
    print(token);
    print(sortby);
    print(ascdsc);
    print(type);
    var header = {
      'Authorization': token,
    };
    var request =
        new http.MultipartRequest("GET", Uri.parse(baseUrl.companies_list))
          ..headers.addAll(header);
    var sortreq = new http.MultipartRequest("POST", Uri.parse(baseUrl.sorting))
      ..headers.addAll(header);
    if (sort) {
      sortreq.fields['sortby'] = sortby;
      sortreq.fields['asc_desc'] = ascdsc;
      sortreq.fields['sorting'] = type;
    }

    var res = sort ? await sortreq.send() : await request.send();

    var response = await http.Response.fromStream(res);

    var n = jsonDecode(response.body);
    print(n);

    removeedu();

    if (sort) {
      if (n['comp_details'] != null)
        for (int i = 0; i < n['comp_details'].length; i++) {
          companyadd(
            acname: n['comp_details'][i]['account_name'],
            acnum: n['comp_details'][i]['account_number'],
            bankname: n['comp_details'][i]['bank_name'],
            descr: n['comp_details'][i]['descr'],
            earnedtilldate: n['comp_details'][i]['earned_till_date'],
            ifsc: n['comp_details'][i]['ifsc'],
            moneyearned: n['comp_details'][i]['money_earned'],
            name: n['comp_details'][i]['name'],
            onliner: n['comp_details'][i]['oneliner'],
            profileurl: n['comp_details'][i]['profile_url'],
            id: n['comp_details'][i]['id'],
            type: n['comp_details'][i]['type'],
          );
        }
    } else {
      for (int j = 0; j < n['comp_details'].length; j++) {
        String i = j.toString();
        companyadd(
          acname: n['comp_details'][i]['account_name'],
          acnum: n['comp_details'][i]['account_number'],
          bankname: n['comp_details'][i]['bank_name'],
          descr: n['comp_details'][i]['descr'],
          earnedtilldate: n['comp_details'][i]['earned_till_date'],
          ifsc: n['comp_details'][i]['ifsc'],
          moneyearned: n['comp_details'][i]['money_earned'],
          name: n['comp_details'][i]['name'],
          onliner: n['comp_details'][i]['oneliner'],
          profileurl: n['comp_details'][i]['profile_url'],
          id: n['comp_details'][i]['id'],
          type: n['comp_details'][i]['type'],
        );
      }
    }
  }

  List<CompanyModel> company = [];

  List<CompanyModel> get companies => company;

  void companyadd({
    String acname,
    String acnum,
    String bankname,
    String descr,
    String earnedtilldate,
    int id,
    String ifsc,
    String moneyearned,
    String name,
    String onliner,
    String profileurl,
    String type,
  }) {
    companies.add(CompanyModel(
        acname: acname,
        acnum: acnum,
        bankname: bankname,
        descr: descr,
        earnedtilldate: earnedtilldate,
        id: id,
        ifsc: ifsc,
        moneyearned: moneyearned,
        name: name,
        onliner: onliner,
        profileurl: profileurl,
        type: type));
    notifyListeners();
  }

  void removeedu() {
    companies.clear();
    notifyListeners();
  }
}
