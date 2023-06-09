import 'package:json_annotation/json_annotation.dart';

import 'package:vk_app/domain/entity/news_feed/posts/attachment.dart';
import 'package:vk_app/domain/entity/news_feed/posts/comments.dart';
import 'package:vk_app/domain/entity/news_feed/posts/reposts.dart';
import 'package:vk_app/domain/entity/news_feed/posts/likes.dart';
import 'package:vk_app/domain/entity/news_feed/posts/views.dart';
import 'package:vk_app/domain/entity/entity_date_parser.dart';

part 'post.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Post {
  final String type;
  final int sourceId;
  @JsonKey(fromJson: parseDateFromUnixTimeStamp)
  final DateTime date;
  final double shortTextRate;
  final Object donut;
  final Comments comments;
  final int? markedAsAds;
  final bool? canSetCategory;
  final bool? canDoubtCategory;
  final List<Attachment> attachments;
  final int id;
  final bool isFavorite;
  final Likes likes;
  final int ownerId;
  final int postId;
  final Object postSource;
  final String postType;
  final Reposts reposts;
  final String text;
  final Views? views;

  Post({
    required this.type,
    required this.sourceId,
    required this.date,
    required this.shortTextRate,
    required this.donut,
    required this.comments,
    required this.markedAsAds,
    required this.canSetCategory,
    required this.canDoubtCategory,
    required this.attachments,
    required this.id,
    required this.isFavorite,
    required this.likes,
    required this.ownerId,
    required this.postId,
    required this.postSource,
    required this.postType,
    required this.reposts,
    required this.text,
    required this.views,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);
}
