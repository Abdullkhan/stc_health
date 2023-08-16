import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class BaseProvider {}

class DetailPageProvider extends BaseProvider {
  static Future addDetailProducts({required int id}) async {
    var request = http.Request('GET', Uri.parse('https://fakestoreapi.com/products/$id'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var getResponse = await response.stream.bytesToString();
      var decoded = jsonDecode(getResponse);
      return decoded;
    } else {
      print(response.reasonPhrase);
    }
  }
}
