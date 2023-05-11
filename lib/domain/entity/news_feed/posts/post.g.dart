// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      type: json['type'] as String,
      sourceId: json['source_id'] as int,
      date: parseDateFromUnixTimeStamp(json['date'] as int),
      shortTextRate: (json['short_text_rate'] as num).toDouble(),
      donut: json['donut'] as Object,
      comments: Comments.fromJson(json['comments'] as Map<String, dynamic>),
      markedAsAds: json['marked_as_ads'] as int?,
      canSetCategory: json['can_set_category'] as bool?,
      canDoubtCategory: json['can_doubt_category'] as bool?,
      attachments: (json['attachments'] as List<dynamic>)
          .map((e) => Attachment.fromJson(e as Map<String, dynamic>))
          .toList(),
      id: json['id'] as int,
      isFavorite: json['is_favorite'] as bool,
      likes: Likes.fromJson(json['likes'] as Map<String, dynamic>),
      ownerId: json['owner_id'] as int,
      postId: json['post_id'] as int,
      postSource: json['post_source'] as Object,
      postType: json['post_type'] as String,
      reposts: Reposts.fromJson(json['reposts'] as Map<String, dynamic>),
      text: json['text'] as String,
      views: json['views'] == null
          ? null
          : Views.fromJson(json['views'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'type': instance.type,
      'source_id': instance.sourceId,
      'date': instance.date.toIso8601String(),
      'short_text_rate': instance.shortTextRate,
      'donut': instance.donut,
      'comments': instance.comments.toJson(),
      'marked_as_ads': instance.markedAsAds,
      'can_set_category': instance.canSetCategory,
      'can_doubt_category': instance.canDoubtCategory,
      'attachments': instance.attachments.map((e) => e.toJson()).toList(),
      'id': instance.id,
      'is_favorite': instance.isFavorite,
      'likes': instance.likes.toJson(),
      'owner_id': instance.ownerId,
      'post_id': instance.postId,
      'post_source': instance.postSource,
      'post_type': instance.postType,
      'reposts': instance.reposts.toJson(),
      'text': instance.text,
      'views': instance.views?.toJson(),
    };
