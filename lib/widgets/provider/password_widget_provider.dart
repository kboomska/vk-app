import 'package:flutter/material.dart';

class PasswordWidgetModelProvider extends InheritedNotifier {
  final PasswordWidgetModel model;

  const PasswordWidgetModelProvider({
    super.key,
    required this.model,
    required Widget child,
  }) : super(
          notifier: model,
          child: child,
        );

  static PasswordWidgetModelProvider? noticeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<PasswordWidgetModelProvider>();
  }

  static PasswordWidgetModelProvider? readOnly(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<PasswordWidgetModelProvider>()
        ?.widget;
    return widget is PasswordWidgetModelProvider ? widget : null;
  }
}

class PasswordWidgetModel extends ChangeNotifier {
  // String? _password;
  String? _password = 'admin'; // For testing only!
  String? _errorText;
  bool? _isError;
  // bool? _isContinue;
  bool? _isContinue = true; // For testing only!
  bool _isObscure = true;

  set password(String value) {
    _password = value;
    _isError = false;

    textFieldCheckError(value);
    notifyListeners();
  }

  String? get errorText {
    return _errorText;
  }

  bool? get isError {
    return _isError;
  }

  bool? get isContinue {
    return _isContinue;
  }

  bool get isObscure {
    return _isObscure;
  }

  String get password {
    return _password ?? '';
  }

  void obscureText() {
    _isObscure = !_isObscure;

    notifyListeners();
  }

  void goToHomeScreen(BuildContext context) {
    final password = _password;

    if (password == 'admin') {
      _errorText = null;
      _isError = false;

      // Navigator.of(context).pushReplacementNamed('/home');
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/home', ModalRoute.withName('/'));
    } else {
      _errorText = 'Неверный пароль, проверьте правильность введенных данных';
      _isError = true;
      print('Ошибка при вводе пароля');
    }
    notifyListeners();
  }

  void textFieldCheckError(String text) {
    _errorText = null;

    if (text == '') {
      _isContinue = false;
    } else {
      _isContinue = true;
    }
  }

  void forgottenPassword() {
    print('Забыли пароль?');
  }
}
