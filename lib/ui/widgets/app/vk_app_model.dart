import 'package:flutter/material.dart';

import 'package:vk_app/domain/data_provider/access_data_provider.dart';
import 'package:vk_app/ui/navigation/main_navigation.dart';

class VKAppModel {
  final _accessDataProvider = AccessDataProvider();

  Future<void> resetSession(BuildContext context) async {
    await _accessDataProvider.setAccessToken(null);
    if (context.mounted) {
      await Navigator.of(context).pushNamedAndRemoveUntil(
        MainNavigationRouteNames.login,
        (_) => false,
      );
    }
  }
}
