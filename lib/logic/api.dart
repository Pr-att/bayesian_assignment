import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  get() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/photos'),
    );
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data;
    } else {
      return ('Failed with status code: ${response.statusCode}');
    }
  }

  post(int id, String title, String thumbnailUrl, String url) async {
    final response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/photos'),
      headers: {
        'Content-type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'id': id,
        'title': title,
        'thumbnailUrl': thumbnailUrl,
        'url': url,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      return ('Failed with status code: ${response.statusCode}');
    }
  }
}
