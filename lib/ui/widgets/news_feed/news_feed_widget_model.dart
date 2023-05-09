import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:vk_app/domain/entity/news_feed/profiles/profile.dart';
import 'package:vk_app/domain/entity/news_feed/groups/group.dart';
import 'package:vk_app/domain/entity/news_feed/posts/post.dart';
import 'package:vk_app/domain/api_client/api_client.dart';

class NewsFeedWidgetModel extends ChangeNotifier {
  final _apiClient = ApiClient();
  final _posts = <Post>[];
  final _groups = <Group>[];
  final _profiles = <Profile>[];

  List<Post> get posts => List.unmodifiable(_posts);

  String stringDate(int date) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(date * 1000);
    final day = DateFormat.MMMMd().format(dateTime);
    final time = DateFormat.Hm().format(dateTime);
    return '$day в $time';
  }

  String stringViews(int viewsCount) {
    String stringCount;
    if (viewsCount < 1000) {
      stringCount = viewsCount.toString();
    } else if (viewsCount < 10000) {
      stringCount = '${(viewsCount / 1000).toStringAsFixed(1)}K';
    } else if (viewsCount < 1000000) {
      stringCount = '${viewsCount % 1000}K';
    } else if (viewsCount < 10000000) {
      stringCount = '${(viewsCount / 1000000).toStringAsFixed(1)}M';
    } else {
      stringCount = '${viewsCount % 1000000}M';
    }
    return stringCount;
  }

  Map<String, dynamic> getPostHeaderData(int sourceId) {
    final sourceData = <String, dynamic>{};
    if (sourceId < 0) {
      final group = _groups.firstWhere((group) => group.id == sourceId.abs());
      sourceData['name'] = group.name;
      sourceData['photo'] = group.photo50;
    } else {
      final profile = _profiles.firstWhere((profile) => profile.id == sourceId);
      sourceData['name'] = '${profile.firstName} ${profile.lastName}';
      sourceData['photo'] = profile.photo50;
    }
    return sourceData;
  }

  Future<void> loadNewsFeeds() async {
    final newsFeedsResponse = await _apiClient.getNewsFeed();
    _posts.addAll(newsFeedsResponse.posts);
    notifyListeners();
    _groups.addAll(newsFeedsResponse.groups);
    _profiles.addAll(newsFeedsResponse.profiles);
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
