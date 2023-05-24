import 'package:flutter/material.dart';

import 'package:vk_app/domain/data_provider/access_data_provider.dart';
import 'package:vk_app/domain/api_client/auth_api_client.dart';
import 'package:vk_app/ui/navigation/main_navigation.dart';

class AuthService {
  final _accessDataProvider = AccessDataProvider();
  final _authApiClient = AuthApiClient();

  Future<bool> isAuth() async {
    final accessToken = await _accessDataProvider.getAccessToken();
    return accessToken != null;
  }

  Future<void> auth(BuildContext context) async {
    final accessToken = await _authApiClient.auth(context);

    print('Auth token: $accessToken');
    await _accessDataProvider.setAccessToken(accessToken);
  }

  Future<void> logout(BuildContext context) async {
    await _accessDataProvider.removeAccessToken();
    if (context.mounted) MainNavigation.resetNavigation(context);
  }
}
