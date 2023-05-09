import 'package:hive_flutter/hive_flutter.dart';

import 'package:vk_app/domain/entity/messenger/message.dart';
import 'package:vk_app/domain/entity/messenger/chat.dart';

class BoxManager {
  static final BoxManager instance = BoxManager._();
  final Map<String, int> _boxCounter = <String, int>{};

  BoxManager._();

  Future<Box<Chat>> openChatBox() async {
    return _openBox('chats_box', 1, ChatAdapter());
  }

  Future<Box<Message>> openMessagesBox(int chatKey) async {
    return _openBox(makeMessagesBoxName(chatKey), 2, MessageAdapter());
  }

  Future<void> closeBox<T>(Box<T> box) async {
    if (!box.isOpen) {
      _boxCounter.remove(box.name);
      return;
    }

    int count = _boxCounter[box.name] ?? 1;
    count -= 1;
    _boxCounter[box.name] = count;
    if (count > 0) return;

    _boxCounter.remove(box.name);
    await box.compact();
    await box.close();
  }

  String makeMessagesBoxName(int chatKey) => 'messages_box_$chatKey';

  Future<Box<T>> _openBox<T>(
    String name,
    int typeId,
    TypeAdapter<T> adapter,
  ) async {
    if (Hive.isBoxOpen(name)) {
      final count = _boxCounter[name] ?? 1;
      _boxCounter[name] = count + 1;
      return Hive.box(name);
    }
    _boxCounter[name] = 1;

    if (!Hive.isAdapterRegistered(typeId)) {
      Hive.registerAdapter(adapter);
    }

    return Hive.openBox<T>(name);
  }
}
