import 'package:flutter/material.dart';

import 'package:vk_app/ui/navigation/main_navigation.dart';

class PasswordWidgetModel extends ChangeNotifier {
  final String _login;
  // String _password = '';
  String _password = 'admin'; // For testing only!
  String? _errorText;
  bool _isObscure = true;

  PasswordWidgetModel({required login}) : _login = login;

  String get login => _login;
  bool get isPassword => _password.isNotEmpty;
  bool get isObscure => _isObscure;
  String? get errorText => _errorText;

  set password(String value) {
    _password = value;

    if (_errorText != null) {
      _errorText = null;
    }

    if (value == '') {
      _isObscure = true;
    }
    notifyListeners();
  }

  void obscureText() {
    _isObscure = !_isObscure;

    notifyListeners();
  }

  void goToHomeScreen(BuildContext context) {
    final password = _password;

    if (password == 'admin') {
      Navigator.of(context).pushNamedAndRemoveUntil(
        MainNavigationRouteNames.home,
        (_) => false,
      );
    } else {
      _errorText = 'Неверный пароль, проверьте правильность введенных данных';
      notifyListeners();
    }
  }

  void forgottenPassword() {
    print('Забыли пароль?');
  }
}
