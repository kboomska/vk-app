import 'package:flutter/material.dart';

import 'package:vk_app/domain/data_provider/access_data_provider.dart';
import 'package:vk_app/ui/navigation/main_navigation.dart';

class VKAppModel {
  final _accessDataProvider = AccessDataProvider();
  var _isAuth = false;

  bool get isAuth => _isAuth;

  Future<void> checkAuth() async {
    final accessToken = await _accessDataProvider.getAccessToken();
    _isAuth = accessToken != null;
  }

  Future<void> resetSession(BuildContext context) async {
    await _accessDataProvider.setAccessToken(null);
    await Navigator.of(context).pushNamedAndRemoveUntil(
      MainNavigationRouteNames.login,
      (route) => false,
    );
  }
}
