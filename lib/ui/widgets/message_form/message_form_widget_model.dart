import 'package:flutter/material.dart';

import 'package:vk_app/domain/data_provider/box_manager.dart';
import 'package:vk_app/domain/entity/message.dart';

class MessageFormWidgetModel extends ChangeNotifier {
  final int chatKey;
  var _messageText = '';

  bool get isMessage => _messageText.isNotEmpty;
  bool get isSpaceOnly => _messageText.trim().isEmpty;

  MessageFormWidgetModel({required this.chatKey});

  set messageText(String value) {
    _messageText = value;

    notifyListeners();
  }

  void saveMessage(BuildContext context) async {
    final messageText = _messageText.trim();
    if (messageText.isEmpty) return;

    final message = Message(text: messageText);
    final box = await BoxManager.instance.openMessagesBox(chatKey);
    await box.add(message);
    await BoxManager.instance.closeBox(box);

    _messageText = '';
    notifyListeners();
  }

  void closeForm(BuildContext context) {
    Navigator.of(context).pop();
  }
}
