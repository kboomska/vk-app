import 'package:vk_app/domain/data_provider/access_data_provider.dart';

class VKAppModel {
  final _accessDataProvider = AccessDataProvider();
  var _isAuth = false;

  bool get isAuth => _isAuth;

  Future<void> checkAuth() async {
    final accessToken = await _accessDataProvider.getAccessToken();
    _isAuth = accessToken != null;
  }
}
