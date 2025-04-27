import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gym_tracker_x/models/user.dart';

class AuthService {
  // Your backend URL (make sure it's correct)
  final String _baseUrl =
      "http://10.0.2.2:5000/api/auth/login"; // Example for a locally running backend

  // Login function
  Future<User?> login(String username, String password) async {
    try {
      // Debugging output for the sent data
      print("Sending login data: username=$username, password=$password");

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      // Check the status code and log corresponding information
      if (response.statusCode == 200) {
        // Successful login, JWT token and user data received
        print("Successful response received: ${response.body}");

        try {
          final data = jsonDecode(response.body);

          // Debugging output for received data
          print("Response data: $data");

          // Make sure the response contains a token
          if (data['token'] == null) {
            print("Error: Token missing in the response");
            return null;
          }

          // Create a User object and assign the token
          return User.fromJson(data);
        } catch (e) {
          print("Error parsing JSON response: $e");
          return null;
        }
      } else {
        // Error response from the server
        print("Error response from server: ${response.statusCode}");
        print("Response content: ${response.body}");
        return null;
      }
    } catch (e) {
      // Request error (e.g., network issues)
      print("Request error: $e");
      return null; // Return null in case of network or other errors
    }
  }
}
