import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:vk_app/ui/widgets/messages/messages_widget.dart';
import 'package:vk_app/domain/data_provider/box_manager.dart';
import 'package:vk_app/ui/navigation/main_navigation.dart';
import 'package:vk_app/domain/entity/messenger/chat.dart';

class ChatsWidgetModel extends ChangeNotifier {
  late final Future<Box<Chat>> _box;
  ValueListenable<Object>? _listenableBox;
  var _chats = <Chat>[];

  ChatsWidgetModel() {
    _setup();
  }

  List<Chat> get chats => _chats.toList();

  void showForm(BuildContext context) {
    Navigator.of(context).pushNamed(MainNavigationRouteNames.chatForm);
  }

  Future<void> showMessages(BuildContext context, int indexChat) async {
    final chat = (await _box).getAt(indexChat);

    if (chat != null) {
      final configuration = MessagesWidgetConfiguration(
        chat.key as int,
        chat.name,
      );

      Navigator.of(context).pushNamed(MainNavigationRouteNames.messages,
          arguments: configuration);
    }
  }

  Future<void> deleteChat(int indexChat) async {
    final box = await _box;

    final chatKey = (await _box).keyAt(indexChat) as int;
    final messagesBoxName = BoxManager.instance.makeMessagesBoxName(chatKey);
    await Hive.deleteBoxFromDisk(messagesBoxName);

    await box.deleteAt(indexChat);
  }

  Future<void> _readChatsFromHive() async {
    _chats = (await _box).values.toList();
    notifyListeners();
  }

  Future<void> _setup() async {
    _box = BoxManager.instance.openChatBox();

    await _readChatsFromHive();

    _listenableBox = (await _box).listenable();
    _listenableBox?.addListener(_readChatsFromHive);
  }

  @override
  void dispose() async {
    _listenableBox?.removeListener(_readChatsFromHive);
    await BoxManager.instance.closeBox(await _box);
    super.dispose();
  }
}
