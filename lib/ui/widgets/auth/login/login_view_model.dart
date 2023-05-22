import 'package:flutter/material.dart';

import 'package:vk_app/domain/data_provider/access_data_provider.dart';
import 'package:vk_app/ui/navigation/main_navigation.dart';
import 'package:vk_app/domain/api_client/api_client.dart';

class LoginViewModel extends ChangeNotifier {
  final _client = ApiClient();
  final _accessDataProvider = AccessDataProvider();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> auth(BuildContext context) async {
    String? accessToken;

    _errorMessage = null;
    try {
      accessToken = await _client.auth(context);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          _errorMessage =
              'Сервер не доступен. Проверьте подключение к интернету';
          break;
        case ApiClientExceptionType.authCancel:
          _errorMessage = 'Авторизация отменена пользователем';
          break;
        case ApiClientExceptionType.other:
          _errorMessage = 'Произошла ошибка. Попробуйте ещё раз';
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
    if (context.mounted) {
      Navigator.of(context).pushReplacementNamed(MainNavigationRouteNames.home);
    }
  }

  void loginWithApple() {
    _errorMessage = null;
    notifyListeners();

    print('Войти через Apple');
  }
}
