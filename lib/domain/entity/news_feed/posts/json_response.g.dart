// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonResponse _$JsonResponseFromJson(Map<String, dynamic> json) => JsonResponse(
      response:
          NewsFeedResponse.fromJson(json['response'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$JsonResponseToJson(JsonResponse instance) =>
    <String, dynamic>{
      'response': instance.response.toJson(),
    };
