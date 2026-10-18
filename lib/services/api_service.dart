import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Choreo Base URL
  static const String baseUrl = 'https://7b003a5c-ca96-409d-a0ac-9c9cda66539c-dev.e1-us-east-azure.choreoapis.dev/smart-transit-new/smart-transit-backend/v1.0';

  // Header settings
  static Map<String, String> get headers => {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };

  // Sign In API Call
  static Future<http.Response> signIn(String email, String password) async {
    final url = Uri.parse('$baseUrl/auth/signin');
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
    return response;
  }

  // Sign Up API Call
  static Future<http.Response> signUp(Map<String, dynamic> userData) async {
    final url = Uri.parse('$baseUrl/auth/signup');
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(userData),
    );
    return response;
  }
}