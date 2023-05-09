import 'package:hive_flutter/hive_flutter.dart';

part 'message.g.dart';

@HiveType(typeId: 2)
class Message extends HiveObject {
  @HiveField(0)
  String text;

  @HiveField(1)
  DateTime time = DateTime.now();

  Message({
    required this.text,
  });
}
