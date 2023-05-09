import 'package:json_annotation/json_annotation.dart';

part 'size.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Size {
  final int height;
  final String type;
  final int width;
  final String url;

  Size({
    required this.height,
    required this.type,
    required this.width,
    required this.url,
  });

  factory Size.fromJson(Map<String, dynamic> json) => _$SizeFromJson(json);

  Map<String, dynamic> toJson() => _$SizeToJson(this);
}
