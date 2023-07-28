import 'package:http/http.dart' as http;

class NetworkService {
  static Future<http.Response> post({required String url, Map<String, dynamic>? body, String? token}) {
    Map<String, String> headers = {
      "Accept": "application/json",
      'Content-Type': 'application/json'
    };

    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return http.post(Uri.parse(url), headers: headers, body: body);
  }
}