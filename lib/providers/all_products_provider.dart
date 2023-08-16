import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class BaseProvider {}

class AllProductsProvider extends BaseProvider {
  static Future addAllProducts() async {
    try {
      var request = http.Request('GET', Uri.parse('https://fakestoreapi.com/products'));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var getResponse = await response.stream.bytesToString();
        var decoded = jsonDecode(getResponse);
        return decoded;
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
