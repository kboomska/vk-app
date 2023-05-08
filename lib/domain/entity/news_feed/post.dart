import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Post {
  final String type;
  final int sourceId;
  final int date;
  final double shortTextRate;
  final Object donut;
  final Object comments;
  final int markedAsAds;
  final bool? canSetCategory;
  final bool? canDoubtCategory;
  final List<Object> attachments;
  final int id;
  final bool isFavorite;
  final Object likes;
  final int ownerId;
  final int postId;
  final Object postSource;
  final String postType;
  final Object reposts;
  final String text;
  final Object views;

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
