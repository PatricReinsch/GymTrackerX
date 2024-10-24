import 'package:flutter/material.dart';
import 'package:gym_tracker_x/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'GymTrackerX',
      home: HomeScreen(),
    );
  }
}
