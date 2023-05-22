import 'package:flutter/material.dart';

import 'package:vk_app/ui/navigation/main_navigation.dart';
import 'package:vk_app/domain/api_client/api_client.dart';
import 'package:vk_app/domain/services/auth_service.dart';

class LoginViewModel extends ChangeNotifier {
  final _authService = AuthService();

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<void> auth(BuildContext context) async {
    _errorMessage = await _login(context);

    if (_errorMessage == null) {
      if (context.mounted) {
        MainNavigation.resetNavigation(context);
      }
    } else {
      notifyListeners();
    }
  }

  Future<String?> _login(BuildContext context) async {
    try {
      await _authService.auth(context);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          return 'Сервер не доступен. Проверьте подключение к интернету';
        case ApiClientExceptionType.authCancel:
          return 'Авторизация отменена пользователем';
        case ApiClientExceptionType.other:
          return 'Произошла ошибка. Попробуйте ещё раз';
        default:
          break;
      }
    } catch (e) {
      return 'Ошибка авторизации, повторите попытку';
    }
    return null;
  }

  void loginWithApple() {
    _errorMessage = null;
    notifyListeners();

    print('Войти через Apple');
  }
}
