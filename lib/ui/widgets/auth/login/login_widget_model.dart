import 'package:flutter/material.dart';

import 'package:vk_app/ui/navigation/main_navigation.dart';
import 'package:vk_app/domain/api_client/api_client.dart';

class LoginWidgetModel extends ChangeNotifier {
  final _client = ApiClient();
  String _token = '';

  // String _login = '';
  String _login = 'admin@mail.ru'; // For testing only!
  final loginTextController =
      TextEditingController(text: 'admin@mail.ru'); // For testing only!

  String? _errorText;

  bool get isLogin => _login.isNotEmpty;
  String? get errorText => _errorText;

  set login(String value) {
    _login = value;

    if (_errorText != null) {
      _errorText = null;
    }
    notifyListeners();
  }

  Future<void> auth(BuildContext context) async {
    final clientId = loginTextController.text;
    String response = '';

    // await _apiClient.getToken(clientId);

    try {
      response = await _client.auth(context, clientId);
      _token = _client.getResponseFragments(response)['access_token'];
    } catch (error) {
      print('Ошибка авторизации');
    }

    print('Auth response: $response');
    print('Auth token: $_token');
  }

  void goToPasswordScreen(BuildContext context) {
    final login = _login;

    if (login == 'admin@mail.ru') {
      Navigator.of(context)
          .pushNamed(MainNavigationRouteNames.password, arguments: login);
    } else if (login.isEmpty) {
      _errorText = 'Не указана почта';
      notifyListeners();
    } else {
      _errorText = 'Неверный адрес почты';
      notifyListeners();
    }
  }

  void goToSignInScreen() {
    print('Зарегистрироваться');
  }
}

class LoginWidgetModelProvider extends InheritedNotifier {
  final LoginWidgetModel model;

  const LoginWidgetModelProvider({
    super.key,
    required this.model,
    required Widget child,
  }) : super(
          notifier: model,
          child: child,
        );

  static LoginWidgetModelProvider? noticeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<LoginWidgetModelProvider>();
  }

  static LoginWidgetModelProvider? readOnly(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<LoginWidgetModelProvider>()
        ?.widget;
    return widget is LoginWidgetModelProvider ? widget : null;
  }
}
