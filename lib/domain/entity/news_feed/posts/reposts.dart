import 'package:json_annotation/json_annotation.dart';

part 'reposts.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Reposts {
  final int count;
  final int userReposted;

  Reposts({
    required this.count,
    required this.userReposted,
  });

  factory Reposts.fromJson(Map<String, dynamic> json) =>
      _$RepostsFromJson(json);

  Map<String, dynamic> toJson() => _$RepostsToJson(this);
}
