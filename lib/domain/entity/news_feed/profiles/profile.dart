import 'package:json_annotation/json_annotation.dart';

import 'package:vk_app/domain/entity/news_feed/profiles/online_info.dart';

part 'profile.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Profile {
  final int id;
  final int sex;
  final String screenName;
  @JsonKey(name: 'photo_50')
  final String photo50;
  @JsonKey(name: 'photo_100')
  final String photo100;
  final OnlineInfo onlineInfo;
  final int online;
  final String firstName;
  final String lastName;
  final bool canAccessClosed;
  final bool isClosed;

  Profile({
    required this.id,
    required this.sex,
    required this.screenName,
    required this.photo50,
    required this.photo100,
    required this.onlineInfo,
    required this.online,
    required this.firstName,
    required this.lastName,
    required this.canAccessClosed,
    required this.isClosed,
  });

  factory Profile.fromJson(Map<String, dynamic> json) =>
      _$ProfileFromJson(json);

  Map<String, dynamic> toJson() => _$ProfileToJson(this);
}
