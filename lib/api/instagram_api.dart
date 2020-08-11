import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

String url = 'https://45b3d39e2c2b.ngrok.io/insta/mittechtatva';
List caption = []; //list of the captions
List shortcode =
    []; //list of shortcode of each post - used to get the external url to link the user to the particular post;for posts- /p/<shortcode> , for igtv it is /tv/<shortcode>
List likes = []; //stores no. of likes
List display = [];

class getInstaInfo {
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

  static Future storeData() async {
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
        //this loops over each post of the multiple thread
        for (var multipleposts in eachpost['node']['edge_sidecar_to_children']
            ['edges']) {
          getInstaInfo().displayData(multipleposts);
        }
      } else {
        getInstaInfo().displayData(eachpost);
      }
    }
    //IMPORTANT: Add print statements here to print(in the terminal) the data lists that have been stored and see their structure and working
  }

  //this function is responsible for storing the urls for displaying the post depending on whether its an image(GraphImage) or video(GraphVideo)
  void displayData(Map singlepost) {
    if (singlepost['node']['__typename'] == 'GraphImage') {
      display
          .add('${singlepost['node']['display_url']}'); //stores url for image
    } else if (singlepost['node']['__typename'] == 'GraphVideo') {
      //storing the thumbnail url(display_url)for the video as well as video url in a list of 2 items and adding that list to the main display list i.e nested list
      //CAUTION: if the nesting is not taking place properly for any reason, then add only the video url to the display list, dont create another list to store thumbnail as well
      display.add([
        '${singlepost['node']['display_url']}', //remove this to not store thumbnail
        '${singlepost['node']['video_url']}'
      ]);
    }
  }
}