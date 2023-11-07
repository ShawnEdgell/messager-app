import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  final FlutterSecureStorage _storage =
      const FlutterSecureStorage(); // Updated to use const constructor

  Future<void> setAuthToken(String token) async {
    await _storage.write(key: 'authToken', value: token);
  }

  Future<String?> getAuthToken() async {
    return await _storage.read(key: 'authToken');
  }

  Future<void> deleteAuthToken() async {
    await _storage.delete(key: 'authToken');
  }
}
