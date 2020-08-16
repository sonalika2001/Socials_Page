import 'dart:convert';
import 'package:http/http.dart' as http;

String url = 'https://45b3d39e2c2b.ngrok.io/insta/mittechtatva';

class getInstaInfo {
  List caption = []; //list of the captions
  List shortcode =
      []; //list of shortcode of each post - used to get the external url to link the user to the particular post;for posts- /p/<shortcode> , for igtv it is /tv/<shortcode>
  List likes = []; //stores no. of likes
  List display = []; //stores the photos/video urls

  //gets the data from the api, no need to modify or call this
  static Future<List> getData() async {
    try {
      http.Response _response = await http.get(url);
      if (_response.statusCode == 200) {
        print('reached here');
        var body = jsonDecode(_response.body);
        print('got body');
        List posts = body['entry_data']['ProfilePage'][0]['graphql']['user']
            ['edge_owner_to_timeline_media']['edges'];
        print('got posts');
        return posts;
      }
    } catch (e) {
      print(e);
    }
  }

  Future storeData() async {
    //this function is to be used to access and store the data each time we run the app
    List posts = await getData();
    print('got data');
    //this loop loops over every post of the techtatva page
    for (var eachpost in posts) {
      caption.add(
          '${eachpost['node']['edge_media_to_caption']['edges'][0]['node']['text']}'); //adds caption of that post to the list of captions
      likes.add(eachpost['node']['edge_liked_by']
          ['count']); //adds number of likes on the post to the list of likes
      shortcode.add(
          '${eachpost['node']['shortcode']}'); //adds the shortcode for that post; this is to be used to externally link the insta page incase the user wishes to view the page in the instagram app itself
      String postType =
          '${eachpost['node']['__typename']}'; //this variable stores whether a particular post consists of just one thread or multiple
      //if postType is GraphSidecar its a multiple thread (multiple posts in one post)
      if (postType == 'GraphSidecar') {
        getInstaInfo().displayData(eachpost, postType);
      }
      //if single post
      else {
        getInstaInfo().displayData(eachpost, postType);
      }
    }
    //IMPORTANT: Add print statements here to print(in the terminal) the data lists that have been stored and see their structure and working
  }

//this function is responsible for storing the urls for displaying the post depending on whether its an image(GraphImage) or video(GraphVideo)
  void displayData(Map singlepost, String postType) {
    if (postType == 'GraphSideCar') {
      List multiple =
          []; //this list will store all the display data for a post with multiple threads
      for (var multipleposts in singlepost['node']['edge_sidecar_to_children']
          ['edges']) {
        //looping over each post in the multiple thread and adding them to the list multiple[]
        if (multipleposts['node']['__typename'] == 'GraphImage') {
          multiple.add([
            'image',
            '${multipleposts['node']['display_url']}'
          ]); //stores url for image
        } else if (multipleposts['node']['__typename'] == 'GraphVideo') {
          multiple.add([
            'video',
            '${multipleposts['node']['display_url']}', //thumbnail url
            '${multipleposts['node']['video_url']}'
          ]);
        }
      }
      display.add(
          multiple); //adding the list of display data of the multiple thread to the main display list
    }

    //if its a single post
    else {
      if (singlepost['node']['__typename'] == 'GraphImage') {
        display.add(['image', '${singlepost['node']['display_url']}']);
      } else if (singlepost['node']['__typename'] == 'GraphVideo') {
        display.add([
          'video',
          '${singlepost['node']['display_url']}',
          '${singlepost['node']['video_url']}'
        ]);
      }
    }
  }
}

/* display list heirarchy :
display[
[<postType>,<urls>],  -----> for single posts
[<postType>,<urls>],   -------^
[<postType>,<urls>],   -------^
[<postType>,<urls>],   -------^
 [                       ------> for multiple posts
   [<postType>,<urls>],   ------>each post inside the multiple posts
   [<postType>,<urls>],   --------^
 ]
]
 */
