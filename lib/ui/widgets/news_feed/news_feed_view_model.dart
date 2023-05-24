import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:vk_app/domain/data_provider/access_data_provider.dart';
import 'package:vk_app/domain/entity/news_feed/profiles/profile.dart';
import 'package:vk_app/domain/entity/news_feed/posts/attachment.dart';
import 'package:vk_app/domain/api_client/api_client_exception.dart';
import 'package:vk_app/domain/api_client/news_feed_api_client.dart';
import 'package:vk_app/domain/entity/news_feed/groups/group.dart';
import 'package:vk_app/domain/entity/news_feed/posts/post.dart';

class PostData {
  final PostSourceData sourceData;
  final String postDate;
  final String postText;
  final String postAttachment;
  final String likes;
  final bool userLikes;
  final String comments;
  final String reposts;
  final String? views;

  PostData({
    required this.sourceData,
    required this.postDate,
    required this.postText,
    required this.postAttachment,
    required this.likes,
    required this.userLikes,
    required this.comments,
    required this.reposts,
    required this.views,
  });
}

class PostSourceData {
  final String name;
  final String photo;

  PostSourceData({
    required this.name,
    required this.photo,
  });
}

class NewsFeedViewModel extends ChangeNotifier {
  final _accessDataProvider = AccessDataProvider();
  final _newsFeedApiClient = NewsFeedApiClient();
  final _posts = <PostData>[];
  final _groups = <Group>[];
  final _profiles = <Profile>[];
  bool _isLoadingInProgress = false;
  String? _nextFrom;
  late DateFormat _dateFormat;
  late DateFormat _timeFormat;
  String _locale = '';

  Future<void>? Function()? onAccessTokenExpired;

  List<PostData> get posts => List.unmodifiable(_posts);

  String _stringDate(DateTime date) {
    late String day;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);

    final aDate = DateTime(date.year, date.month, date.day);
    if (aDate == today) {
      day = 'сегодня';
    } else if (aDate == yesterday) {
      day = 'вчера';
    } else {
      day = _dateFormat.format(date);
    }
    final time = _timeFormat.format(date);
    return '$day в $time';
  }

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();

    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.MMMMd(_locale);
    _timeFormat = DateFormat.Hm(_locale);

    await _resetNewsFeed();
  }

  Future<void> _resetNewsFeed() async {
    _posts.clear();
    await _loadNewsFeeds();
  }

  String _stringCounter(int counter) {
    String result;
    if (counter < 1000) {
      result = counter.toString();
    } else if (counter < 10000) {
      result = '${(counter / 1000).toStringAsFixed(1)}K';
    } else if (counter < 1000000) {
      result = '${counter % 1000}K';
    } else if (counter < 10000000) {
      result = '${(counter / 1000000).toStringAsFixed(1)}M';
    } else {
      result = '${counter % 1000000}M';
    }
    return result;
  }

  PostSourceData _getPostSourceData(int sourceId) {
    final PostSourceData sourceData;
    if (sourceId < 0) {
      final group = _groups.firstWhere((group) => group.id == sourceId.abs());
      sourceData = PostSourceData(name: group.name, photo: group.photo50);
    } else {
      final profile = _profiles.firstWhere((profile) => profile.id == sourceId);
      sourceData = PostSourceData(
        name: '${profile.firstName} ${profile.lastName}',
        photo: profile.photo50,
      );
    }
    return sourceData;
  }

  Future<void> _loadNewsFeeds() async {
    final accessToken = await _accessDataProvider.getAccessToken();
    if (_isLoadingInProgress) return;
    _isLoadingInProgress = true;

    try {
      final newsFeedsResponse =
          await _newsFeedApiClient.getNewsFeed(accessToken, _nextFrom);

      _groups.addAll(newsFeedsResponse.groups);
      _profiles.addAll(newsFeedsResponse.profiles);
      _posts.addAll(newsFeedsResponse.posts.map(_preparePostData));
      _nextFrom = newsFeedsResponse.nextFrom;

      _isLoadingInProgress = false;
      notifyListeners();
    } on ApiClientException catch (e) {
      _handleApiClientException(e);
    } catch (e) {
      _isLoadingInProgress = false;
    }
  }

  PostData _preparePostData(Post post) {
    final views = post.views?.count;
    return PostData(
      sourceData: _getPostSourceData(post.sourceId),
      postDate: _stringDate(post.date),
      postText: post.text,
      postAttachment: _setAttachmentByType(post.attachments),
      likes: _stringCounter(post.likes.count),
      userLikes: post.likes.userLikes == 1,
      comments: _stringCounter(post.comments.count),
      reposts: _stringCounter(post.reposts.count),
      views: views != null ? _stringCounter(views) : null,
    );
  }

  String _setAttachmentByType(List<Attachment> attachments) {
    if (attachments.isEmpty) return '';
    final attachment = attachments.first;
    if (attachment.type == 'photo') {
      return attachment.photo!.sizes.last.url;
    } else {
      return '';
    }
  }

  void fetchPostsAtIndex(int index) {
    if (index < _posts.length - 1) return;
    _loadNewsFeeds();
  }

  void onTapLikeButton({required int index}) {}

  void _handleApiClientException(ApiClientException exception) {
    switch (exception.type) {
      case ApiClientExceptionType.network:
        print('Сервер не доступен. Проверьте подключение к интернету.');
        break;
      case ApiClientExceptionType.accessToken:
        onAccessTokenExpired?.call();
        break;
      case ApiClientExceptionType.captcha:
        print('Требуется ввод кода с картинки (Captcha).');
        break;
      case ApiClientExceptionType.other:
        print('Произошла ошибка. Попробуйте ещё раз.');
        break;
      default:
        print(exception);
        break;
    }
  }
}
