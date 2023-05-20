import 'package:flutter/material.dart';

import 'package:vk_app/ui/widgets/messages/messages_widget.dart';
import 'package:vk_app/ui/widgets/auth/web_page/web_page.dart';
import 'package:vk_app/domain/factories/screen_factory.dart';

abstract class MainNavigationRouteNames {
  static const loader = '/';
  static const login = '/login';
  static const password = '/login/password';
  static const oauth = '/login/oauth';
  static const home = '/home';
  static const chatForm = '/home/chatForm';
  static const messages = '/home/messages';
}

class MainNavigation {
  static final _screenFactory = ScreenFactory();
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.loader: (_) => _screenFactory.createLoader(),
    MainNavigationRouteNames.login: (_) => _screenFactory.createLogin(),
    MainNavigationRouteNames.home: (_) => _screenFactory.createHome(),
    MainNavigationRouteNames.chatForm: (_) => _screenFactory.createChatForm(),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.oauth:
        final configuration = settings.arguments as WebPageConfiguration;
        return MaterialPageRoute(
          builder: (_) => _screenFactory.createOAuth(configuration),
        );
      case MainNavigationRouteNames.password:
        final login = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => _screenFactory.createPassword(login),
        );
      case MainNavigationRouteNames.messages:
        final configuration = settings.arguments as MessagesWidgetConfiguration;
        return MaterialPageRoute(
          builder: (_) => _screenFactory.createMessages(configuration),
        );
      default:
        const widget = Text('Navigation Error!');
        return MaterialPageRoute(
          builder: (_) => widget,
        );
    }
  }
}
