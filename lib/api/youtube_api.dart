import 'package:http/http.dart' as http;
import 'dart:convert';

class getYoutubeInfo {
  static String url = 'https://45b3d39e2c2b.ngrok.io/youtube/TechTatva';
  static List videoURL =
      []; //will contain list of urls (on calling getYoutubeInfo.youtubePosts() ) that link to the youtube video
  static List thumbnailURL = []; //will contain list of urls of thumbnails
  static List videoTitle = []; //list of the video titles

  static Future getData() async {
    try {
      http.Response _response = await http.get(url);
      var body = jsonDecode(_response.body);
      var video = body['data'];
      return video;
    } catch (e) {
      print(e);
    }
  }

  static Future youtubePosts() async {
    //this function needs to be called to fetch the data for videoURL,thumbnailURL,videoTitle and store it in the above mentioned lists
    var posts = await getData();
    print('reached here');
    for (var post in posts.keys) {
      //looping through data
      videoTitle.add('$post'); //added caption
      videoURL.add(posts[post]['link']); //added video url
      thumbnailURL.add(posts[post]['thumbnail']); //added thumbnail url
    }
    print('over');
  }
}
