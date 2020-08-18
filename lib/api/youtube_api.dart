import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:socials_page/api_path.dart';

class GetYoutubeInfo {
  static String url;
  static List videoURL =
      []; //will contain list of urls (on calling getYoutubeInfo.youtubePosts() ) that link to the youtube video
  static List thumbnailURL = []; //will contain list of urls of thumbnails
  static List videoTitle = []; //list of the video titles
  static List videoDuration = []; //list of the video durations

  static Future getData() async {
    try {
      await getURL.jsonPath();
      url = '${getURL.youtubeURL}TechTatva';
      http.Response _response = await http.get(url);
      if (_response.statusCode == 200) {
        var body = jsonDecode(_response.body);
        var video = body['data'];
        return video;
      } else
        print(_response.statusCode);
    } catch (e) {
      print(e);
    }
  }

  static Future youtubePosts() async {
    //this function needs to be called to fetch the data for videoURL,thumbnailURL,videoTitle and store it in the above mentioned lists
    var posts = await getData();
    if (posts != null) {
      for (var post in posts) {
        //looping through data
        videoTitle.add('${post['title']}'); //added caption
        videoURL.add('${post['link']}'); //added video url
        thumbnailURL.add('${post['thumbnail']}'); //added thumbnail url
        videoDuration.add('${post['time']}'); //added video duration
      }
    }
  }
}
