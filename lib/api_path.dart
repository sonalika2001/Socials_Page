import 'dart:convert';
import 'package:http/http.dart' as http;

class getURL {
  static String instaIgtvURL, instaPostURL, youtubeURL;
  static Future jsonPath() async {
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
      }
    } catch (e) {
      print(e);
    }
  }
}
