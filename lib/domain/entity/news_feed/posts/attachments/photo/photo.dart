import 'package:json_annotation/json_annotation.dart';

import 'package:vk_app/domain/entity/news_feed/posts/attachments/photo/size.dart';

part 'photo.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Photo {
  final int albumId;
  final int date;
  final int id;
  final int ownerId;
  final String accessKey;
  final int? postId;
  final List<Size> sizes;
  final String text;
  final int? userId;
  final bool hasTags;

  Photo({
    required this.albumId,
    required this.date,
    required this.id,
    required this.ownerId,
    required this.accessKey,
    required this.postId,
    required this.sizes,
    required this.text,
    required this.userId,
    required this.hasTags,
  });

  factory Photo.fromJson(Map<String, dynamic> json) => _$PhotoFromJson(json);

  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}
