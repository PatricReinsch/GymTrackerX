import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gym_tracker_x/models/user.dart';
import 'package:gym_tracker_x/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final String _baseUrl = "http://10.0.2.2:5000/api/auth/login"; //backend URL

  // Login function
  Future<User?> login(String username, String password) async {
    try {
      // Use the global logger to log the sent data
      logger.d("Sending login data: username=$username, password=$password");

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        // Successful response
        logger.i("Successful response received: ${response.body}");

        try {
          final data = jsonDecode(response.body);
          logger.d("Response data: $data");

          if (data['token'] == null) {
            logger.e("Error: Token missing in the response");
            return null;
          }

          //return User.fromJson(data);
          final user = User.fromJson(data);

          if (user.userId == null) {
            logger.e("Error: userId missing in the response");
            return null;
          }

          // Save user_id locally
          final prefs = await SharedPreferences.getInstance();
          await prefs.setInt('user_id', user.userId!);

          return user;
        } catch (e) {
          logger.e("Error parsing JSON response: $e");
          return null;
        }
      } else {
        logger.e("Error response from server: ${response.statusCode}");
        logger.e("Response content: ${response.body}");
        return null;
      }
    } catch (e) {
      logger.e("Request error: $e");
      return null;
    }
  }

  // Save user_id locally
  Future<void> saveUserId(int userId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id', userId);
  }
}
