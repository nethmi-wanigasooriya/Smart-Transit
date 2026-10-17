import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart'; 

class ApiService {
  // 1. Sign In API Call
  static Future<Map<String, dynamic>?> signIn(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.signInEndpoint), 
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        return null;
      }
    } catch (e) {
      print('Sign In Error: $e');
      return null;
    }
  }


  static Future<bool> signUp(String name, String email, String password, String role) async {
    try {
      final response = await http.post(
        Uri.parse(ApiConfig.signUpEndpoint), 
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
          'role': role,
        }),
      );

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print('Sign Up Error: $e');
      return false;
    }
  }
}