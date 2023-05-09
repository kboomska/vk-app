// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_feed_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsFeedResponse _$NewsFeedResponseFromJson(Map<String, dynamic> json) =>
    NewsFeedResponse(
      posts: (json['items'] as List<dynamic>)
          .map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList(),
      profiles:
          (json['profiles'] as List<dynamic>).map((e) => e as Object).toList(),
      groups:
          (json['groups'] as List<dynamic>).map((e) => e as Object).toList(),
      nextFrom: json['next_from'] as String,
    );

Map<String, dynamic> _$NewsFeedResponseToJson(NewsFeedResponse instance) =>
    <String, dynamic>{
      'items': instance.posts.map((e) => e.toJson()).toList(),
      'profiles': instance.profiles,
      'groups': instance.groups,
      'next_from': instance.nextFrom,
    };
