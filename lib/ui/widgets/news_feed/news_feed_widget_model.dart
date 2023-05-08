import 'package:flutter/material.dart';

import 'package:vk_app/domain/api_client/api_client.dart';
import 'package:vk_app/domain/entity/news_feed/post.dart';

class NewsFeedWidgetModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  // final _newsfeeds = <NewsFeed>[];
  // List<NewsFeed> get newsfeeds => List.unmodifiable(_newsfeeds);
  final _posts = <Post>[];
  List<Post> get posts => List.unmodifiable(_posts);

  Future<void> loadNewsFeeds() async {
    final newsFeedsResponse = await _apiClient.getNewsFeed();
    print(newsFeedsResponse.posts[0].type);
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
