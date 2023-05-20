import 'package:flutter/material.dart';

import 'package:vk_app/ui/navigation/main_navigation.dart';
import 'package:vk_app/domain/services/auth_service.dart';

class LoaderViewModel {
  final _authService = AuthService();
  BuildContext context;

  LoaderViewModel(this.context) {
    asyncInit();
  }

  Future<void> asyncInit() async {
    await checkAuth();
  }

  Future<void> checkAuth() async {
    final isAuth = await _authService.isAuth();

    final nextScreen =
        isAuth ? MainNavigationRouteNames.home : MainNavigationRouteNames.login;

    await Future<void>.delayed(const Duration(seconds: 1));
    if (context.mounted) {
      await Navigator.of(context).pushReplacementNamed(nextScreen);
    }
  }
}
