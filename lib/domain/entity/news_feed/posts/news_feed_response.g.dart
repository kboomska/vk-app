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
      profiles: (json['profiles'] as List<dynamic>)
          .map((e) => Profile.fromJson(e as Map<String, dynamic>))
          .toList(),
      groups: (json['groups'] as List<dynamic>)
          .map((e) => Group.fromJson(e as Map<String, dynamic>))
          .toList(),
      nextFrom: json['next_from'] as String,
    );

Map<String, dynamic> _$NewsFeedResponseToJson(NewsFeedResponse instance) =>
    <String, dynamic>{
      'items': instance.posts.map((e) => e.toJson()).toList(),
      'profiles': instance.profiles.map((e) => e.toJson()).toList(),
      'groups': instance.groups.map((e) => e.toJson()).toList(),
      'next_from': instance.nextFrom,
    };
