// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Group _$GroupFromJson(Map<String, dynamic> json) => Group(
      id: json['id'] as int,
      name: json['name'] as String,
      screenName: json['screen_name'] as String,
      isClosed: json['is_closed'] as int,
      type: json['type'] as String,
      photo50: json['photo_50'] as String,
      photo100: json['photo_100'] as String,
      photo200: json['photo_200'] as String,
    );

Map<String, dynamic> _$GroupToJson(Group instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'screen_name': instance.screenName,
      'is_closed': instance.isClosed,
      'type': instance.type,
      'photo_50': instance.photo50,
      'photo_100': instance.photo100,
      'photo_200': instance.photo200,
    };
