import 'package:flutter/material.dart';
import 'package:gym_tracker_x/screens/login_screen.dart';
import 'package:dcdg/dcdg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GymTrackerX',
      home: LoginPage(),
    );
  }
}
