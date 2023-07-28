import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:swifties_technoscape/application/repositories/auth/auth_repository.dart';
import 'package:swifties_technoscape/application/service/shared_preferences_service.dart';
import 'package:swifties_technoscape/data/models/token/token_model.dart';

class NetworkService {
  static String baseUrl = 'http://34.101.154.14:8175/hackathon';
  static Future<http.Response> post({required String url, Map<String, dynamic>? body, String? token}) async {
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
    var result = await http.post(Uri.parse(fullUrl), headers: headers, body: jsonEncode(body));
    if (result.statusCode == 401 && token == SharedPreferencesService.getToken()) {
      String username = SharedPreferencesService.getUserData()!.username;
      String password = SharedPreferencesService.getUserData()!.loginPassword;
      TokenModel tokenModel = await AuthRepository().generateToken(username, password);
      await SharedPreferencesService.setToken(tokenModel.accessToken);
      headers['Authorization'] = 'Bearer ${tokenModel.accessToken}';
      result = await http.post(Uri.parse(fullUrl), headers: headers, body: jsonEncode(body));
    }
    return result;
  }
}