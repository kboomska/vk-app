import 'package:flutter/material.dart';

import 'package:vk_app/resources/resources.dart';

class Post {
  final String author;
  final String avatar;
  final String date;
  final String text;
  final String media;
  int reactions;
  final int replies;
  final int share;
  final String views;
  bool isLiked;

  Post({
    required this.author,
    required this.avatar,
    required this.date,
    required this.text,
    required this.media,
    required this.reactions,
    required this.replies,
    required this.share,
    required this.views,
    required this.isLiked,
  });
}

class PostsWidgetModel extends ChangeNotifier {
  var _posts = [
    Post(
      author: 'Другое кино',
      avatar: AppImages.postAvatar,
      date: '15 апр в 11:05',
      text:
          'Thomas Duke путешествует по миру в поисках локаций из любимых фильмов и сериалов. Thomas Duke путешествует по миру в поисках локаций из любимых фильмов и сериалов.',
      media: AppImages.postMedia,
      reactions: 120,
      replies: 2,
      share: 28,
      views: '13K',
      isLiked: true,
    ),
    Post(
      author: 'Другое кино',
      avatar: AppImages.postAvatar,
      date: '15 апр в 11:05',
      text:
          'Thomas Duke путешествует по миру в поисках локаций из любимых фильмов и сериалов. Thomas Duke путешествует по миру в поисках локаций из любимых фильмов и сериалов.',
      media: AppImages.postMedia,
      reactions: 120,
      replies: 2,
      share: 28,
      views: '13K',
      isLiked: false,
    ),
    Post(
      author: 'Другое кино',
      avatar: AppImages.postAvatar,
      date: '15 апр в 11:05',
      text:
          'Thomas Duke путешествует по миру в поисках локаций из любимых фильмов и сериалов. Thomas Duke путешествует по миру в поисках локаций из любимых фильмов и сериалов.',
      media: AppImages.postMedia,
      reactions: 120,
      replies: 2,
      share: 28,
      views: '13K',
      isLiked: false,
    ),
    Post(
      author: 'Другое кино',
      avatar: AppImages.postAvatar,
      date: '15 апр в 11:05',
      text:
          'Thomas Duke путешествует по миру в поисках локаций из любимых фильмов и сериалов. Thomas Duke путешествует по миру в поисках локаций из любимых фильмов и сериалов.',
      media: AppImages.postMedia,
      reactions: 120,
      replies: 2,
      share: 28,
      views: '13K',
      isLiked: false,
    ),
    Post(
      author: 'Другое кино',
      avatar: AppImages.postAvatar,
      date: '15 апр в 11:05',
      text:
          'Thomas Duke путешествует по миру в поисках локаций из любимых фильмов и сериалов. Thomas Duke путешествует по миру в поисках локаций из любимых фильмов и сериалов.',
      media: AppImages.postMedia,
      reactions: 120,
      replies: 2,
      share: 28,
      views: '13K',
      isLiked: false,
    ),
    Post(
      author: 'Другое кино',
      avatar: AppImages.postAvatar,
      date: '15 апр в 11:05',
      text:
          'Thomas Duke путешествует по миру в поисках локаций из любимых фильмов и сериалов. Thomas Duke путешествует по миру в поисках локаций из любимых фильмов и сериалов.',
      media: AppImages.postMedia,
      reactions: 120,
      replies: 2,
      share: 28,
      views: '13K',
      isLiked: false,
    ),
    Post(
      author: 'Другое кино',
      avatar: AppImages.postAvatar,
      date: '15 апр в 11:05',
      text:
          'Thomas Duke путешествует по миру в поисках локаций из любимых фильмов и сериалов. Thomas Duke путешествует по миру в поисках локаций из любимых фильмов и сериалов.',
      media: AppImages.postMedia,
      reactions: 120,
      replies: 2,
      share: 28,
      views: '13K',
      isLiked: false,
    ),
    Post(
      author: 'Другое кино',
      avatar: AppImages.postAvatar,
      date: '15 апр в 11:05',
      text:
          'Thomas Duke путешествует по миру в поисках локаций из любимых фильмов и сериалов. Thomas Duke путешествует по миру в поисках локаций из любимых фильмов и сериалов.',
      media: AppImages.postMedia,
      reactions: 120,
      replies: 2,
      share: 28,
      views: '13K',
      isLiked: false,
    ),
    Post(
      author: 'Другое кино',
      avatar: AppImages.postAvatar,
      date: '15 апр в 11:05',
      text:
          'Thomas Duke путешествует по миру в поисках локаций из любимых фильмов и сериалов. Thomas Duke путешествует по миру в поисках локаций из любимых фильмов и сериалов.',
      media: AppImages.postMedia,
      reactions: 120,
      replies: 2,
      share: 28,
      views: '13K',
      isLiked: false,
    ),
    Post(
      author: 'Другое кино',
      avatar: AppImages.postAvatar,
      date: '15 апр в 11:05',
      text:
          'Thomas Duke путешествует по миру в поисках локаций из любимых фильмов и сериалов. Thomas Duke путешествует по миру в поисках локаций из любимых фильмов и сериалов.',
      media: AppImages.postMedia,
      reactions: 120,
      replies: 2,
      share: 28,
      views: '13K',
      isLiked: false,
    ),
  ];

  List<Post> get posts => _posts;

  void onTapLikeButton({required int index}) {
    _posts[index].isLiked = !_posts[index].isLiked;
    if (_posts[index].isLiked) {
      _posts[index].reactions += 1;
    } else {
      _posts[index].reactions -= 1;
    }
    notifyListeners();
  }
}
