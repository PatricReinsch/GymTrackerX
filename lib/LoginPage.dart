import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Großes "G" Symbol
              CircleAvatar(
                radius: 100,
                backgroundColor: Colors.black,
                child: Text(
                  'G',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 126,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
              SizedBox(height: 10),
              // App-Name
              Text(
                'Gymtrackerx',
                style: TextStyle(
                  fontSize: 58,
                  fontWeight: FontWeight.normal,
                  fontStyle: FontStyle.italic,
                ),
              ),
              SizedBox(height: 80),
              // Benutzername Feld
              TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(
                    color: Colors.black, // Textfarbe für das Label
                    fontSize: 30, // Schriftgröße
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 20),
              // Passwort Feld
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(
                    color: Colors.black, // Textfarbe für das Label
                    fontSize: 30, // Schriftgröße
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                obscureText: true,
              ),
              SizedBox(height: 80),
              // Login Button
              ElevatedButton(
                onPressed: () {
                  // Login-Logik kann hier hinzugefügt werden
                  print("Login tapped");
                },
                child: Text(
                  'Login',
                  style: TextStyle(
                      fontSize: 40,
                      color: Colors.white
                  ),

                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Untertitel
              Text(
                'Start to safe your Gains',
                style: TextStyle(
                  fontSize: 26,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}