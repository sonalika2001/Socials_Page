import 'dart:convert';
import 'package:http/http.dart' as http;

String url =
    'https://api.twitter.com/1.1/search/tweets.json?q=%23covid19&src=typed_query&count=50&f=live';
String token =
    "AAAAAAAAAAAAAAAAAAAAAFgHGwEAAAAAUzIEfdNog1Yn3fV77lyaDr%2FZI0A%3D8htW37Xn5LKKRdikjkSRuWAJnoIBzcprtnJ7K9fbUY6yDyZCl3";

class TwitterApi {
  List texts = [];
  List<List> hashtags = [];
  List user_name = [];
  List screen_name = [];
  List image_url = [];

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
        user_name.add(posts[i]["user"]["name"]);
        screen_name.add(posts[i]["user"]["screen_name"]);
        print(posts[i]["protected"]);
        image_url.add(posts[i]["user"]["profile_image_url"]);
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
