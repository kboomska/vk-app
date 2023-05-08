// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Attachment _$AttachmentFromJson(Map<String, dynamic> json) => Attachment(
      type: json['type'] as String,
      photo: json['photo'] == null
          ? null
          : Photo.fromJson(json['photo'] as Map<String, dynamic>),
      postedPhoto: json['posted_photo'],
      video: json['video'],
      audio: json['audio'],
      doc: json['doc'],
      graffiti: json['graffiti'],
      link: json['link'],
      note: json['note'],
      app: json['app'],
      poll: json['poll'],
      page: json['page'],
      album: json['album'],
      photosList: json['photos_list'],
      market: json['market'],
      marketAlbum: json['market_album'],
      sticker: json['sticker'],
      prettyCards: json['pretty_cards'],
      event: json['event'],
    );

Map<String, dynamic> _$AttachmentToJson(Attachment instance) =>
    <String, dynamic>{
      'type': instance.type,
      'photo': instance.photo?.toJson(),
      'posted_photo': instance.postedPhoto,
      'video': instance.video,
      'audio': instance.audio,
      'doc': instance.doc,
      'graffiti': instance.graffiti,
      'link': instance.link,
      'note': instance.note,
      'app': instance.app,
      'poll': instance.poll,
      'page': instance.page,
      'album': instance.album,
      'photos_list': instance.photosList,
      'market': instance.market,
      'market_album': instance.marketAlbum,
      'sticker': instance.sticker,
      'pretty_cards': instance.prettyCards,
      'event': instance.event,
    };
