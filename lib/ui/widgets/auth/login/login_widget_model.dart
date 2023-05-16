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

  String? _errorMessage;

  bool get isLogin => _login.isNotEmpty;
  String? get errorMessage => _errorMessage;

  set login(String value) {
    _login = value;

    if (_errorMessage != null) {
      _errorMessage = null;
    }
    notifyListeners();
  }

  Future<void> auth(BuildContext context) async {
    String? accessToken;

    _errorMessage = null;
    try {
      accessToken = await _client.auth(context);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          _errorMessage =
              'Сервер не доступен. Проверьте подключение к интернету.';
          break;
        case ApiClientExceptionType.authCancel:
          _errorMessage = 'Авторизация отменена пользователем.';
          break;
        case ApiClientExceptionType.other:
          _errorMessage = 'Произошла ошибка. Попробуйте ещё раз.';
          break;
        default:
          break;
      }
    }

    print('Auth token: $accessToken');

    if (_errorMessage != null) {
      notifyListeners();
      return;
    }

    if (accessToken == null) {
      _errorMessage = 'Ошибка авторизации, повторите попытку';
      notifyListeners();
      return;
    }

    await _accessDataProvider.setAccessToken(accessToken);
    Navigator.of(context).pushReplacementNamed(MainNavigationRouteNames.home);
  }

  void goToPasswordScreen(BuildContext context) {
    final login = _login;

    if (login == 'admin@mail.ru') {
      _errorMessage = null;
      Navigator.of(context)
          .pushNamed(MainNavigationRouteNames.password, arguments: login);
    } else if (login.isEmpty) {
      _errorMessage = 'Не указана почта';
    } else {
      _errorMessage = 'Неверный адрес почты';
    }
    notifyListeners();
  }

  void goToSignInScreen() {
    print('Зарегистрироваться');
  }
}
