import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:vk_app/Library/Widgets/Inherited/provider.dart' as old_provider;
import 'package:vk_app/ui/widgets/auth/password/password_widget.dart';
import 'package:vk_app/ui/widgets/auth/login/login_widget_model.dart';
import 'package:vk_app/ui/widgets/chat_form/chat_form_widget.dart';
import 'package:vk_app/ui/widgets/messages/messages_widget.dart';
import 'package:vk_app/ui/widgets/loader/loader_view_model.dart';
import 'package:vk_app/ui/widgets/auth/login/login_widget.dart';
import 'package:vk_app/ui/widgets/auth/web_page/web_page.dart';
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
    return old_provider.NotifierProvider(
      model: LoginWidgetModel(),
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

  Widget createOAuth(WebPageConfiguration configuration) {
    return WebPageWidget(configuration: configuration);
  }

  Widget createPassword(String login) {
    return PasswordWidget(login: login);
  }

  Widget createMessages(MessagesWidgetConfiguration configuration) {
    return MessagesWidget(configuration: configuration);
  }
}
