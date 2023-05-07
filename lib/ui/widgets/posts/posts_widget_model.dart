import 'package:flutter/material.dart';

import 'package:vk_app/domain/api_client/api_client.dart';

class PostsWidgetModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  // final _newsfeeds = <NewsFeed>[];
  // List<NewsFeed> get newsfeeds => List.unmodifiable(_newsfeeds);
  final _newsfeeds = <dynamic>[];
  List<dynamic> get newsfeeds => List.unmodifiable(_newsfeeds);

  Future<void> loadNewsFeeds() async {
    final newsFeedsResponse = await _apiClient.getNewsFeed();
    print(newsFeedsResponse);
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
