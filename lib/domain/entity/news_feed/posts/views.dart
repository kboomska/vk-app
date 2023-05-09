import 'package:json_annotation/json_annotation.dart';

part 'views.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Views {
  final int count;

  Views({required this.count});

  factory Views.fromJson(Map<String, dynamic> json) => _$ViewsFromJson(json);

  Map<String, dynamic> toJson() => _$ViewsToJson(this);
}
