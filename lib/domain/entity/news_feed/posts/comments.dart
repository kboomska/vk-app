import 'package:json_annotation/json_annotation.dart';

part 'comments.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Comments {
  final int canPost;
  final int count;

  Comments({
    required this.canPost,
    required this.count,
  });

  factory Comments.fromJson(Map<String, dynamic> json) =>
      _$CommentsFromJson(json);

  Map<String, dynamic> toJson() => _$CommentsToJson(this);
}
