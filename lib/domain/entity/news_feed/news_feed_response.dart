import 'package:json_annotation/json_annotation.dart';

import 'package:vk_app/domain/entity/news_feed/post.dart';

part 'news_feed_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class NewsFeedResponse {
  @JsonKey(name: 'items')
  final List<Post> posts;
  final List<Object> profiles;
  final List<Object> groups;
  final String nextFrom;

  NewsFeedResponse({
    required this.posts,
    required this.profiles,
    required this.groups,
    required this.nextFrom,
  });

  factory NewsFeedResponse.fromJson(Map<String, dynamic> json) =>
      _$NewsFeedResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NewsFeedResponseToJson(this);
}