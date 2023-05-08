import 'package:json_annotation/json_annotation.dart';

part 'likes.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Likes {
  final int canLike;
  final int count;
  final int userLikes;
  final int canPublish;
  final bool repostDisabled;

  Likes({
    required this.canLike,
    required this.count,
    required this.userLikes,
    required this.canPublish,
    required this.repostDisabled,
  });

  factory Likes.fromJson(Map<String, dynamic> json) => _$LikesFromJson(json);

  Map<String, dynamic> toJson() => _$LikesToJson(this);
}
