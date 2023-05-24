import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class Keys {
  static const accessToken = 'access_token';
}

class AccessDataProvider {
  static const _secureStorage = FlutterSecureStorage();

  Future<String?> getAccessToken() =>
      _secureStorage.read(key: Keys.accessToken);

  Future<void> setAccessToken(String value) {
    return _secureStorage.write(key: Keys.accessToken, value: value);
  }

  Future<void> removeAccessToken() {
    return _secureStorage.delete(key: Keys.accessToken);
  }
}
