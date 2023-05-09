// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comments.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comments _$CommentsFromJson(Map<String, dynamic> json) => Comments(
      canPost: json['can_post'] as int,
      count: json['count'] as int,
    );

Map<String, dynamic> _$CommentsToJson(Comments instance) => <String, dynamic>{
      'can_post': instance.canPost,
      'count': instance.count,
    };
