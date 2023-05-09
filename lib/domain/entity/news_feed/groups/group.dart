import 'package:json_annotation/json_annotation.dart';

part 'group.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Group {
  final int id;
  final String name;
  final String screenName;
  final int isClosed;
  final String type;
  @JsonKey(name: 'photo_50')
  final String photo50;
  @JsonKey(name: 'photo_100')
  final String photo100;
  @JsonKey(name: 'photo_200')
  final String photo200;

  Group({
    required this.id,
    required this.name,
    required this.screenName,
    required this.isClosed,
    required this.type,
    required this.photo50,
    required this.photo100,
    required this.photo200,
  });

  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  Map<String, dynamic> toJson() => _$GroupToJson(this);
}
