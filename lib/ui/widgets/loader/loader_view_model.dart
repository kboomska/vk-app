import 'package:flutter/material.dart';

import 'package:vk_app/domain/data_provider/access_data_provider.dart';
import 'package:vk_app/ui/navigation/main_navigation.dart';

class LoaderViewModel {
  final _accessDataProvider = AccessDataProvider();
  BuildContext context;

  LoaderViewModel(this.context) {
    asyncInit();
  }

  Future<void> asyncInit() async {
    await checkAuth();
  }

  Future<void> checkAuth() async {
    final accessToken = await _accessDataProvider.getAccessToken();
    final isAuth = accessToken != null;

    final nextScreen =
        isAuth ? MainNavigationRouteNames.home : MainNavigationRouteNames.login;

    await Future<void>.delayed(const Duration(seconds: 1));
    if (context.mounted) {
      await Navigator.of(context).pushReplacementNamed(nextScreen);
    }
  }
}
