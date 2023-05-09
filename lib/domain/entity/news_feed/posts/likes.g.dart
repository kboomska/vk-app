// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'likes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Likes _$LikesFromJson(Map<String, dynamic> json) => Likes(
      canLike: json['can_like'] as int,
      count: json['count'] as int,
      userLikes: json['user_likes'] as int,
      canPublish: json['can_publish'] as int,
      repostDisabled: json['repost_disabled'] as bool,
    );

Map<String, dynamic> _$LikesToJson(Likes instance) => <String, dynamic>{
      'can_like': instance.canLike,
      'count': instance.count,
      'user_likes': instance.userLikes,
      'can_publish': instance.canPublish,
      'repost_disabled': instance.repostDisabled,
    };
