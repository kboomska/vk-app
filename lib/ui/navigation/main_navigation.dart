import 'package:flutter/material.dart';

import 'package:vk_app/ui/widgets/auth/password/password_widget.dart';
import 'package:vk_app/ui/widgets/chat_form/chat_form_widget.dart';
import 'package:vk_app/ui/widgets/messages/messages_widget.dart';
import 'package:vk_app/ui/widgets/auth/login/login_widget.dart';
import 'package:vk_app/ui/widgets/auth/web_page/web_page.dart';
import 'package:vk_app/ui/widgets/home/home_widget.dart';

abstract class MainNavigationRouteNames {
  static const login = 'login';
  static const password = 'login/password';
  static const oauth = 'login/oauth';
  static const home = 'home';
  static const chatForm = 'home/chatForm';
  static const messages = 'home/messages';
}

class MainNavigation {
  String initialRoute(bool isAuth) =>
      isAuth ? MainNavigationRouteNames.home : MainNavigationRouteNames.login;

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.login: (context) => const LoginWidget(),
    MainNavigationRouteNames.home: (context) => const HomeWidget(),
    MainNavigationRouteNames.chatForm: (context) => const ChatFormWidget(),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.oauth:
        final configuration = settings.arguments as WebPageConfiguration;
        return MaterialPageRoute(
            builder: (context) => WebPageWidget(configuration: configuration));
      case MainNavigationRouteNames.password:
        final login = settings.arguments as String;
        return MaterialPageRoute(
            builder: (context) => PasswordWidget(login: login));
      case MainNavigationRouteNames.messages:
        final configuration = settings.arguments as MessagesWidgetConfiguration;
        return MaterialPageRoute(
            builder: (context) => MessagesWidget(configuration: configuration));
      default:
        const widget = Text('Navigation Error!');
        return MaterialPageRoute(
          builder: (context) => widget,
        );
    }
  }
}
