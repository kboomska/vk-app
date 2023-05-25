import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:vk_app/ui/widgets/message_form/message_form_widget_model.dart';
import 'package:vk_app/ui/widgets/auth/oauth_web_page/oauth_web_page.dart';
import 'package:vk_app/ui/widgets/chat_form/chat_form_widget_model.dart';
import 'package:vk_app/ui/widgets/message_form/message_form_widget.dart';
import 'package:vk_app/ui/widgets/messages/messages_widget_model.dart';
import 'package:vk_app/ui/widgets/news_feed/news_feed_view_model.dart';
import 'package:vk_app/ui/widgets/auth/login/login_view_model.dart';
import 'package:vk_app/ui/widgets/chat_form/chat_form_widget.dart';
import 'package:vk_app/ui/widgets/news_feed/news_feed_widget.dart';
import 'package:vk_app/ui/widgets/messages/messages_widget.dart';
import 'package:vk_app/ui/widgets/chats/chats_widget_model.dart';
import 'package:vk_app/ui/widgets/loader/loader_view_model.dart';
import 'package:vk_app/ui/widgets/auth/login/login_widget.dart';
import 'package:vk_app/ui/widgets/loader/loader_widget.dart';
import 'package:vk_app/ui/widgets/chats/chats_widget.dart';
import 'package:vk_app/ui/widgets/home/home_widget.dart';

class ScreenFactory {
  Widget createLoader() {
    return Provider(
      lazy: false,
      create: (context) => LoaderViewModel(context),
      child: const LoaderWidget(),
    );
  }

  Widget createLogin() {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(),
      child: const LoginWidget(),
    );
  }

  Widget createHome() {
    return const HomeWidget();
  }

  Widget createOAuthWebPage(OAuthWebPageConfiguration configuration) {
    return OAuthWebPageWidget(configuration: configuration);
  }

  Widget createMessages(MessagesWidgetConfiguration configuration) {
    return ChangeNotifierProvider(
      create: (_) => MessagesWidgetModel(configuration: configuration),
      child: const MessagesWidget(),
    );
  }

  Widget createMessageForm(int chatKey) {
    return ChangeNotifierProvider(
      create: (_) => MessageFormWidgetModel(chatKey: chatKey),
      child: const MessageFormWidget(),
    );
  }

  Widget createNewsFeed() {
    return ChangeNotifierProvider(
      create: (_) => NewsFeedViewModel(),
      child: const NewsFeedWidget(),
    );
  }

  Widget createChats() {
    return ChangeNotifierProvider(
      create: (_) => ChatsWidgetModel(),
      child: const ChatsWidget(),
    );
  }

  Widget createChatForm() {
    return ChangeNotifierProvider(
      create: (_) => ChatFormWidgetModel(),
      child: const ChatFormWidget(),
    );
  }
}
