import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:gym_tracker_x/widgets/logo_with_name_below.dart';
import 'package:gym_tracker_x/widgets/custom_button_black.dart';
import 'package:gym_tracker_x/widgets/custom_button_white.dart';
import 'package:gym_tracker_x/screens/login_screen.dart';
import 'dart:convert';
import 'package:gym_tracker_x/utils/logger.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  RegisterScreenState createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Function to register a user
  Future<void> _registerUser(String username, String password) async {
    final url = Uri.parse(
        'http://10.0.2.2:5000/api/auth/register'); // Your API URL here

    try {
      // Log the data being sent
      logger.d(
          "Sending registration data: username=$username, password=$password");

      // Sending POST request
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );

      // Log the API response
      logger.d('Response Status Code: ${response.statusCode}');
      logger.d('Response Body: ${response.body}');

      if (!mounted) {
        return; // Ensure widget is still mounted before doing UI updates
      }

      if (response.statusCode == 201) {
        // Successful registration
        logger.i("User successfully registered!");

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Successfully registered!'),
          backgroundColor: Colors.green,
        ));

        // Navigate to the login screen
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else {
        // Error in registration
        logger.e('Registration Error: ${response.body}');

        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Registration Error: ${response.body}'),
          backgroundColor: Colors.red,
        ));
      }
    } catch (error) {
      // Log the error
      logger.e("Error: $error");

      // Only update the UI if the widget is still mounted
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error: $error'),
          backgroundColor: Colors.red,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LogoWithNameBelow(title: "Gym Tracker"),
              SizedBox(height: 100),
              // Username TextField
              TextField(
                controller: _usernameController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide:
                        const BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Password TextField
              TextField(
                controller: _passwordController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide:
                        const BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 40),
              // Register Button
              CustomButtonBlack(
                label: "Register",
                onPressed: () {
                  String username = _usernameController.text;
                  String password = _passwordController.text;

                  // Check if username and password are not empty
                  if (username.isEmpty || password.isEmpty) {
                    logger.w('Username and password cannot be empty.');
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Username and password cannot be empty.'),
                        backgroundColor: Colors.red,
                      ));
                    }
                    return;
                  }

                  logger.d('Sending registration for user: $username');
                  _registerUser(username, password);
                },
              ),
              const SizedBox(height: 20),
              // Back to Login Button
              CustomButtonWhite(
                label: "Back to Login",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
