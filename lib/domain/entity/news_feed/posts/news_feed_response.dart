import 'package:json_annotation/json_annotation.dart';

import 'package:vk_app/domain/entity/news_feed/profiles/profile.dart';
import 'package:vk_app/domain/entity/news_feed/groups/group.dart';
import 'package:vk_app/domain/entity/news_feed/posts/post.dart';

part 'news_feed_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class NewsFeedResponse {
  @JsonKey(name: 'items')
  final List<Post> posts;
  final List<Profile> profiles;
  final List<Group> groups;
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
