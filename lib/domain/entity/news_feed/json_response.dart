import 'package:json_annotation/json_annotation.dart';

import 'package:vk_app/domain/entity/news_feed/news_feed_response.dart';

part 'json_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class JsonResponse {
  final NewsFeedResponse response;

  JsonResponse({required this.response});

  factory JsonResponse.fromJson(Map<String, dynamic> json) =>
      _$JsonResponseFromJson(json);

  Map<String, dynamic> toJson() => _$JsonResponseToJson(this);
}
