import 'package:flutter/material.dart';

import 'package:vk_app/domain/data_provider/box_manager.dart';
import 'package:vk_app/domain/entity/chat.dart';

class ChatFormWidgetModel extends ChangeNotifier {
  String _chatName = '';
  String? errorText;

  bool get isValid => _chatName.trim().isNotEmpty;

  set chatName(String value) {
    _chatName = value;

    if (errorText != null) {
      errorText = null;
    }
    notifyListeners();
  }

  void saveChat(BuildContext context) async {
    final chatName = _chatName.trim();
    if (chatName.isEmpty) {
      errorText = 'Введите имя';
      notifyListeners();
      return;
    }

    final box = await BoxManager.instance.openChatBox();
    final chat = Chat(name: chatName);
    await box.add(chat);
    await BoxManager.instance.closeBox(box);

    closeForm(context);
  }

  void closeForm(BuildContext context) {
    Navigator.of(context).pop();
  }
}

class ChatFormWidgetModelProvider extends InheritedNotifier {
  final ChatFormWidgetModel model;

  const ChatFormWidgetModelProvider({
    super.key,
    required this.model,
    required Widget child,
  }) : super(
          notifier: model,
          child: child,
        );

  static ChatFormWidgetModelProvider? noticeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<ChatFormWidgetModelProvider>();
  }

  static ChatFormWidgetModelProvider? readOnly(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<ChatFormWidgetModelProvider>()
        ?.widget;
    return widget is ChatFormWidgetModelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(ChatFormWidgetModelProvider oldWidget) {
    return false;
  }
}
