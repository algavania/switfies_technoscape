import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkService {
  static String baseUrl = 'http://34.101.154.14:8175/hackathon';
  static Future<http.Response> post({required String url, Map<String, dynamic>? body, String? token}) {
    Map<String, String> headers = {
      "Accept": "*/*",
      'Content-Type': 'application/json'
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    String fullUrl = baseUrl + url;
    print('url $fullUrl');
    print('body ${jsonEncode(body)}');
    return http.post(Uri.parse(fullUrl), headers: headers, body: jsonEncode(body));
  }
}