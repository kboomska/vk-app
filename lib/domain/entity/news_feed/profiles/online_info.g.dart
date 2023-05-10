// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'online_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OnlineInfo _$OnlineInfoFromJson(Map<String, dynamic> json) => OnlineInfo(
      visible: json['visible'] as bool,
      isOnline: json['is_online'] as bool?,
      isMobile: json['is_mobile'] as bool?,
    );

Map<String, dynamic> _$OnlineInfoToJson(OnlineInfo instance) =>
    <String, dynamic>{
      'visible': instance.visible,
      'is_online': instance.isOnline,
      'is_mobile': instance.isMobile,
    };
