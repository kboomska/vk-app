import 'package:flutter/material.dart';

import 'package:vk_app/domain/data_provider/access_data_provider.dart';
import 'package:vk_app/ui/navigation/main_navigation.dart';
import 'package:vk_app/domain/api_client/api_client.dart';

class LoginWidgetModel extends ChangeNotifier {
  final _client = ApiClient();
  final _accessDataProvider = AccessDataProvider();

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
    String? response;
    String? accessToken;

    _errorText = null;
    try {
      response = await _client.auth(context, clientId);
    } catch (error) {
      _errorText = 'Неизвестная ошибка';
    }

    print('Auth response: $response');

    if (_errorText != null) {
      notifyListeners();
      return;
    }

    if (response == null) {
      _errorText = 'Ошибка авторизации, повторите попытку';
      notifyListeners();
      return;
    }

    accessToken = _client.getResponseFragments(response)['access_token'];
    print('Auth token: $accessToken');

    await _accessDataProvider.setAccessToken(accessToken);
    Navigator.of(context).pushReplacementNamed(MainNavigationRouteNames.home);
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
