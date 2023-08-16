import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class BaseProvider {}

class LoginProvider extends BaseProvider {
  static Future addLoginProvider() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var request = http.Request('POST', Uri.parse('https://fakestoreapi.com/auth/login'));
      request.body = json.encode(
        {
          "username": "mor_2314",
          "password": "83r5^_",
        },
      );
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var responses = await response.stream.bytesToString();

        var decoded = jsonDecode(responses);
        print(decoded['token']);
        return decoded['token'];
      } else {
        print(response);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
