import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class PocketBaseService {
  final String _baseUrl =
      'http://localhost:8090/api'; // Ensure no trailing slash
  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  String? _authToken;

  PocketBaseService() {
    _loadStoredToken();
  }

  Future<void> _loadStoredToken() async {
    _authToken = await _secureStorage.read(key: 'authToken');
  }

  Future<void> setAuthToken(String token) async {
    _authToken = token;
    await _secureStorage.write(key: 'authToken', value: token);
  }

  Future<void> clearAuthToken() async {
    _authToken = null;
    await _secureStorage.delete(key: 'authToken');
  }

  Future<String> signUp(String email, String password) async {
    var url = Uri.parse('$_baseUrl/users');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      await setAuthToken(data['token']);
      return data['token'];
    } else {
      throw Exception(
          'Failed to sign up with status code ${response.statusCode}: ${response.body}');
    }
  }

  Future<void> signIn(String email, String password) async {
    var url = Uri.parse('$_baseUrl/auth/signin');
    var response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      var data = json.decode(response.body);
      await setAuthToken(data['token']);
    } else {
      throw Exception(
          'Failed to sign in with status code ${response.statusCode}: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> getCurrentUserProfile() async {
    if (_authToken == null) {
      throw Exception('Not authenticated');
    }

    var url = Uri.parse('$_baseUrl/users/me');
    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_authToken',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception(
          'Failed to get user profile with status code ${response.statusCode}: ${response.body}');
    }
  }

  // Add your message operations methods here...
}
