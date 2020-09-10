import 'dart:convert';
import 'package:http/http.dart' as http;

class GetURL {
  static String instaIgtvURL, instaPostURL, youtubeURL;
  static bool fetched = false;
  static Future jsonPath() async {
    print(fetched);
    if (fetched) return;
    try {
      http.Response _response =
          await http.get('http://dahardik.pythonanywhere.com/');
      if (_response.statusCode == 200) {
        print('reached here');
        var body = jsonDecode(_response.body);
        print('got body');

        instaIgtvURL = '${body['igtv']}';
        instaPostURL = '${body['posts']}';
        youtubeURL = '${body['youtube']}';

        print(instaIgtvURL);
        print(instaPostURL);
        print(youtubeURL);
        fetched = true;
        print(fetched);
      }
    } catch (e) {
      print(e);
    }
  }
}
