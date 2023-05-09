import 'package:json_annotation/json_annotation.dart';

import 'package:vk_app/domain/entity/news_feed/posts/attachments/photo/photo.dart';

part 'attachment.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Attachment {
  final String type;
  final Photo? photo;
  final Object? postedPhoto;
  final Object? video;
  final Object? audio;
  final Object? doc;
  final Object? graffiti;
  final Object? link;
  final Object? note;
  final Object? app;
  final Object? poll;
  final Object? page;
  final Object? album;
  final Object? photosList;
  final Object? market;
  final Object? marketAlbum;
  final Object? sticker;
  final Object? prettyCards;
  final Object? event;

  Attachment({
    required this.type,
    this.photo,
    this.postedPhoto,
    this.video,
    this.audio,
    this.doc,
    this.graffiti,
    this.link,
    this.note,
    this.app,
    this.poll,
    this.page,
    this.album,
    this.photosList,
    this.market,
    this.marketAlbum,
    this.sticker,
    this.prettyCards,
    this.event,
  });

  factory Attachment.fromJson(Map<String, dynamic> json) =>
      _$AttachmentFromJson(json);

  Map<String, dynamic> toJson() => _$AttachmentToJson(this);
}
