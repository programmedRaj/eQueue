import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:convert/convert.dart';

Future<http.Response> httpPostRequest(String url, Map<String, String> headers,
    Map<String, dynamic> postData) async {
  var _uri = Uri.parse(url);
  http.Response response = await http
      .post(_uri, headers: headers, body: jsonEncode(postData))
      .timeout(
    Duration(seconds: 8),
    onTimeout: () {
      return http.Response.bytes(
        [],
        100,
      );
    },
  );

  return response;
}

Future<http.Response> httpGetRequest(
    String url, Map<String, String> header) async {
  http.Response response = await http.get(url, headers: header).timeout(
    Duration(seconds: 8),
    onTimeout: () {
      return http.Response.bytes(
        [],
        100,
      );
    },
  );
  return response;
}
