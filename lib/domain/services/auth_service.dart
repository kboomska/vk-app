import 'package:vk_app/domain/data_provider/access_data_provider.dart';

class AuthService {
  final _accessDataProvider = AccessDataProvider();

  Future<bool> isAuth() async {
    final accessToken = await _accessDataProvider.getAccessToken();
    return accessToken != null;
  }
}
