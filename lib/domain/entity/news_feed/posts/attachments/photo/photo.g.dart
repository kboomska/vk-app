// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Photo _$PhotoFromJson(Map<String, dynamic> json) => Photo(
      albumId: json['album_id'] as int,
      date: json['date'] as int,
      id: json['id'] as int,
      ownerId: json['owner_id'] as int,
      accessKey: json['access_key'] as String?,
      postId: json['post_id'] as int?,
      sizes: (json['sizes'] as List<dynamic>)
          .map((e) => Size.fromJson(e as Map<String, dynamic>))
          .toList(),
      text: json['text'] as String,
      userId: json['user_id'] as int?,
      hasTags: json['has_tags'] as bool,
    );

Map<String, dynamic> _$PhotoToJson(Photo instance) => <String, dynamic>{
      'album_id': instance.albumId,
      'date': instance.date,
      'id': instance.id,
      'owner_id': instance.ownerId,
      'access_key': instance.accessKey,
      'post_id': instance.postId,
      'sizes': instance.sizes.map((e) => e.toJson()).toList(),
      'text': instance.text,
      'user_id': instance.userId,
      'has_tags': instance.hasTags,
    };
