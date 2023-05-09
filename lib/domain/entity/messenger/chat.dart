import 'package:hive_flutter/hive_flutter.dart';

part 'chat.g.dart';

@HiveType(typeId: 1)
class Chat extends HiveObject {
  // removed HiveField indexes: 1
  @HiveField(0)
  String name;

  Chat({
    required this.name,
  });
}
