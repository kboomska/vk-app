import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:vk_app/Library/Widgets/Inherited/provider.dart' as old_provider;
import 'package:vk_app/ui/widgets/auth/oauth_web_page/oauth_web_page.dart';
import 'package:vk_app/ui/widgets/auth/login/login_view_model.dart';
import 'package:vk_app/ui/widgets/chat_form/chat_form_widget.dart';
import 'package:vk_app/ui/widgets/messages/messages_widget.dart';
import 'package:vk_app/ui/widgets/loader/loader_view_model.dart';
import 'package:vk_app/ui/widgets/auth/login/login_widget.dart';
import 'package:vk_app/ui/widgets/home/home_widget_model.dart';
import 'package:vk_app/ui/widgets/loader/loader_widget.dart';
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
    return old_provider.NotifierProvider(
      model: HomeWidgetModel(),
      child: const HomeWidget(),
    );
  }

  Widget createChatForm() {
    return const ChatFormWidget();
  }

  Widget createOAuthWebPage(OAuthWebPageConfiguration configuration) {
    return OAuthWebPageWidget(configuration: configuration);
  }

  Widget createMessages(MessagesWidgetConfiguration configuration) {
    return MessagesWidget(configuration: configuration);
  }
}
