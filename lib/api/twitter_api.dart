import 'dart:convert';
import 'package:http/http.dart' as http;

String url = 'https://api.twitter.com/1.1/statuses/user_timeline.json?screen_name=MITtechtatva&count=10';
String token = "AAAAAAAAAAAAAAAAAAAAAFgHGwEAAAAAOqUaXqmYx53gZU0asDP7ahuqOao%3D5UngfGsGNe8dOOKDl1cpw8PsIb2z7u0M43NbsGN3AjMt0Bl9GN";


class TwitterApi{

  List texts = [];
  List<List> hashtags = [];
  List primary ;
  static Future<List> getData() async {
    try {
      http.Response _response = await http.get(url , headers : {"Authorization" : "Bearer " + token});
      if (_response.statusCode == 200) {
        var body = jsonDecode(_response.body);
        List posts = body;
        return posts;
      }
    } catch (e) {
      print(e);
    }
  }

  Future storeData() async {
    //this function is to be used to access and store the data each time we run the app
    List posts = await getData();

    for (var eachpost in posts) {
primary = [];
      texts.add(
          eachpost['text']);
      for(var index in eachpost['entities']['hashtags'])
      {
        primary.add(index["text"]);
      }
      hashtags.add(primary);

    }
  }

}

