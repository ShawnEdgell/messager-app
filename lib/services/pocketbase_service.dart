import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class PocketBaseService {
  final String _baseUrl = 'http://localhost:8090/api/';
  final FlutterSecureStorage _secureStorage =
      const FlutterSecureStorage(); // Updated to use const constructor

  String? _authToken;

  // Initialize the service by loading the stored auth token if available
  PocketBaseService() {
    _loadStoredToken();
  }
  // Load the auth token from secure storage
  Future<void> _loadStoredToken() async {
    _authToken = await _secureStorage.read(key: 'authToken');
  }

  // Set the auth token and store it securely
  Future<void> setAuthToken(String token) async {
    _authToken = token;
    await _secureStorage.write(key: 'authToken', value: token);
  }

  // Clear the auth token and remove it from secure storage
  Future<void> clearAuthToken() async {
    _authToken = null;
    await _secureStorage.delete(key: 'authToken');
  }

  // Method to sign up a new user and return the auth token
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
      // Assuming the API returns a token upon successful signup
      await setAuthToken(
          data['token']); // Save the auth token for future requests
      return data[
          'token']; // Return the token in case the calling function needs it
    } else {
      // Handle error
      throw Exception('Failed to sign up: ${response.body}');
    }
  }

  // Method to sign in a user
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
      // Handle error
      throw Exception('Failed to sign in: ${response.body}');
    }
  }

  // Method to get the current user's profile
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
      throw Exception('Failed to get user profile: ${response.body}');
    }
  }

  // Method to sign out a user
  Future<void> signOut() async {
    await clearAuthToken();
    // No further action required for PocketBase since token is invalidated locally
  }

  // Add your message operations methods here...
}
