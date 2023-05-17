import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:vk_app/domain/data_provider/access_data_provider.dart';
import 'package:vk_app/domain/entity/news_feed/profiles/profile.dart';
import 'package:vk_app/domain/entity/news_feed/groups/group.dart';
import 'package:vk_app/domain/entity/news_feed/posts/post.dart';
import 'package:vk_app/domain/api_client/api_client.dart';

class NewsFeedWidgetModel extends ChangeNotifier {
  final _accessDataProvider = AccessDataProvider();
  final _apiClient = ApiClient();
  final _posts = <Post>[];
  final _groups = <Group>[];
  final _profiles = <Profile>[];
  bool _isLoadingInProgress = false;
  String? _nextFrom;
  late DateFormat _dateFormat;
  late DateFormat _timeFormat;
  String _locale = '';

  Future<void>? Function()? onAccessTokenExpired;

  List<Post> get posts => List.unmodifiable(_posts);

  String stringDate(DateTime date) {
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

  String stringCounter(int counter) {
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

  Future<void> _loadNewsFeeds() async {
    final accessToken = await _accessDataProvider.getAccessToken();
    if (_isLoadingInProgress) return;
    _isLoadingInProgress = true;

    try {
      final newsFeedsResponse =
          await _apiClient.getNewsFeed(accessToken, _nextFrom);
      _posts.addAll(newsFeedsResponse.posts);

      _groups.addAll(newsFeedsResponse.groups);
      _profiles.addAll(newsFeedsResponse.profiles);
      _nextFrom = newsFeedsResponse.nextFrom;

      _isLoadingInProgress = false;
      notifyListeners();
    } on ApiClientException catch (e) {
      _handleApiClientException(e);
    } catch (e) {
      _isLoadingInProgress = false;
    }
  }

  void fetchPostsAtIndex(int index) {
    if (index < _posts.length - 1) return;
    _loadNewsFeeds();
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
