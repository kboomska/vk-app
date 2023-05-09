// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reposts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reposts _$RepostsFromJson(Map<String, dynamic> json) => Reposts(
      count: json['count'] as int,
      userReposted: json['user_reposted'] as int,
    );

Map<String, dynamic> _$RepostsToJson(Reposts instance) => <String, dynamic>{
      'count': instance.count,
      'user_reposted': instance.userReposted,
    };
