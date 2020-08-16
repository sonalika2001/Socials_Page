import 'dart:convert';
import 'package:http/http.dart' as http;

String url =
    'https://api.twitter.com/1.1/search/tweets.json?q=%23covid19&src=typed_query&count=10&f=live';
String token = "";

class TwitterApi {
  List texts = [];
  List<List> hashtags = [];

  static Future<List> getData() async {
    try {
      http.Response _response =
          await http.get(url, headers: {"authorization": "Bearer " + token});
      if (_response.statusCode == 200) {
        var body = jsonDecode(_response.body);
        List posts = body["statuses"];

        return posts;
      }
      print(_response.statusCode);
    } catch (e) {
      print(e);
    }
  }

  Future storeData() async {
    //this function is to be used to access and store the data each time we run the app
    List posts = await getData();

    List temp = List();
    if (posts != null) {
      for (int i = 0; i < posts.length; i++) {
        temp = [];
        texts.add(posts[i]['text'].toString());

        if (posts[i]["entities"]["hashtags"] != null) {
          for (var tag in posts[i]["entities"]["hashtags"]) {
            temp.add(tag["text"]);
          }
        }
        hashtags.add(temp);
      }
    }
  }
}
