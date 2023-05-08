import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:vk_app/domain/api_client/api_client.dart';
import 'package:vk_app/domain/entity/news_feed/post.dart';

class NewsFeedWidgetModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _posts = <Post>[];

  List<Post> get posts => List.unmodifiable(_posts);

  String stringDate(int date) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(date * 1000);
    final day = DateFormat.MMMMd().format(dateTime);
    final time = DateFormat.Hm().format(dateTime);
    return '$day в $time';
  }

  Future<void> loadNewsFeeds() async {
    final newsFeedsResponse = await _apiClient.getNewsFeed();
    _posts.addAll(newsFeedsResponse.posts);
    notifyListeners();
  }

  void onTapLikeButton({required int index}) {
    // _posts[index].isLiked = !_posts[index].isLiked;
    // if (_posts[index].isLiked) {
    //   _posts[index].reactions += 1;
    // } else {
    //   _posts[index].reactions -= 1;
    // }
    // notifyListeners();
  }
}
