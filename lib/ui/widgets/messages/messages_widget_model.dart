import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:vk_app/ui/widgets/messages/messages_widget.dart';
import 'package:vk_app/domain/data_provider/box_manager.dart';
import 'package:vk_app/domain/entity/message.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MessagesWidgetModel extends ChangeNotifier {
  final MessagesWidgetConfiguration configuration;
  late final Future<Box<Message>> _box;
  ValueListenable<Object>? _listenableBox;

  var _messages = <Message>[];

  MessagesWidgetModel({required this.configuration}) {
    _setup();
  }

  List<Message> get messages => _messages.toList();

  Future<void> deleteMessage(int indexMessage) async {
    final messageLastIndex = _messages.length - 1;
    await (await _box).deleteAt(messageLastIndex - indexMessage);
  }

  Future<void> _readMessagesFromHive() async {
    _messages = (await _box).values.toList().reversed.toList();
    notifyListeners();
  }

  Future<void> _setup() async {
    _box = BoxManager.instance.openMessagesBox(configuration.chatKey);

    await _readMessagesFromHive();

    _listenableBox = (await _box).listenable();
    _listenableBox?.addListener(_readMessagesFromHive);
  }

  @override
  void dispose() async {
    _listenableBox?.removeListener(_readMessagesFromHive);
    await BoxManager.instance.closeBox(await _box);
    super.dispose();
  }
}
