import 'package:json_annotation/json_annotation.dart';

part 'online_info.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OnlineInfo {
  final bool visible;
  final bool? isOnline;
  final bool? isMobile;

  OnlineInfo({
    required this.visible,
    required this.isOnline,
    required this.isMobile,
  });

  factory OnlineInfo.fromJson(Map<String, dynamic> json) =>
      _$OnlineInfoFromJson(json);

  Map<String, dynamic> toJson() => _$OnlineInfoToJson(this);
}
