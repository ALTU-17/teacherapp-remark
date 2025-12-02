import 'package:http/http.dart' as http;
import 'dart:convert';




class Config {

  // static const String getUrlApi = "https://api.aceventura.in/demo/evolvuURL/get_url";

  static const String getUrlApi = "https://api.aceventura.in/evolvuURL/get_url";

  static String? dynamicEndpoint;

  /// Fetch dynamic endpoint from API
  static Future<void> fetchDynamicEndpoint() async {
    try {
      final response = await http.get(Uri.parse(getUrlApi));

      if (response.statusCode == 200) {
        final body = json.decode(response.body);

        // The API returns just a string, e.g. "https://api.aceventura.in/demo/evolvuUserService/"
        if (body is String && body.isNotEmpty) {
          // Optional: remove trailing slash for cleaner concatenation
          dynamicEndpoint = body.endsWith('/')
              ? body.substring(0, body.length - 1)
              : body;
          print("fetching dynamic endpoint: $dynamicEndpoint");
        } else {
          throw Exception("Invalid API response format");
        }
      } else {
        throw Exception("Failed to fetch endpoint: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching dynamic endpoint: $e");
    }
  }
}
