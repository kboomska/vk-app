import 'package:flutter/material.dart';

import 'package:vk_app/domain/data_provider/access_data_provider.dart';
import 'package:vk_app/domain/api_client/api_client.dart';

class AuthService {
  final _accessDataProvider = AccessDataProvider();
  final _client = ApiClient();

  Future<bool> isAuth() async {
    final accessToken = await _accessDataProvider.getAccessToken();
    return accessToken != null;
  }

  Future<void> auth(BuildContext context) async {
    final accessToken = await _client.auth(context);

    print('Auth token: $accessToken');
    await _accessDataProvider.setAccessToken(accessToken);
  }
}
