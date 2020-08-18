import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:socials_page/api_path.dart';

class getIgtvInfo {
  static String url;
  List igtvCaption = [];
  List igtvTitle =
      []; //a title for the igtv video, use this instead of caption if caption takes up lot of space on screen
  List igtvVideoUrl = [];
  List igtvThumbnailUrl = [];
  List igtvShortCode = [];
  List igtvLikes = [];

  static Future getIgtvData() async {
    try {
      await getURL.jsonPath();
      url = '${getURL.instaURL}mittechtatva';
      http.Response _response = await http.get(url);
      if (_response.statusCode == 200) {
        print('reached here');
        var body = jsonDecode(_response.body);
        print('got body');
        List posts = body['entry_data']['ProfilePage'][0]['graphql']['user']
            ['edge_felix_video_timeline']['edges'];
        print('got posts');
        return posts;
      }
    } catch (e) {
      print(e);
    }
  }

  Future storeIgtvData() async {
    List posts = await getIgtvData();
    print('got igtv data');
    for (var eachpost in posts) {
      igtvCaption.add(
          '${eachpost['node']['edge_media_to_caption']['edges'][0]['node']['text']}');

      igtvTitle.add('${eachpost['node']['title']}');

      igtvLikes.add(eachpost['node']['edge_liked_by']['count']);

      igtvShortCode.add('${eachpost['node']['shortcode']}');

      igtvThumbnailUrl.add('${eachpost['node']['display_url']}');

      igtvVideoUrl.add('${eachpost['node']['video_url']}');
    }
    print(igtvTitle);
  }
}
