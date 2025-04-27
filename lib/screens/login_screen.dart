import 'package:flutter/material.dart';
import 'package:gym_tracker_x/widgets/logo_with_name_below.dart';
import 'package:gym_tracker_x/widgets/custom_button_black.dart';
import 'package:gym_tracker_x/widgets/custom_button_white.dart';
import 'package:gym_tracker_x/screens/register_screen.dart';
import 'package:gym_tracker_x/screens/home_screen.dart';
import 'package:gym_tracker_x/services/auth_service.dart';
import 'package:gym_tracker_x/models/user.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService =
      AuthService(); // Create instance of AuthService

  bool _isLoading = false; // Track loading state

  void _login() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    String username = _usernameController.text;
    String password = _passwordController.text;

    // Authenticate using AuthService
    User? user = await _authService.login(username, password);

    setState(() {
      _isLoading = false; // Hide loading indicator
    });

    if (user != null) {
      // Successfully logged in, navigate to HomeScreen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      // Show an error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid username or password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LogoWithNameBelow(title: "Gym Tracker"),
            SizedBox(height: 100),
            // Username textfield
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
                  borderSide: const BorderSide(color: Colors.black, width: 2.0),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Password textfield
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
                  borderSide: const BorderSide(color: Colors.black, width: 2.0),
                ),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 40),
            // Login Button
            _isLoading
                ? CircularProgressIndicator() // Show loading indicator
                : CustomButtonBlack(
                    label: "Login",
                    onPressed: _login,
                  ),
            const SizedBox(height: 20),
            // 'Go to RegisterScreen' Button
            CustomButtonWhite(
              label: "Create account",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
