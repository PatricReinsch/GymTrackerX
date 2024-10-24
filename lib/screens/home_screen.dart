import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GymTrackerX')),
      body: Center(
        child: TextButton(
          child: const Text('Click Me!'), // Corrected: Wrap the text in a Text widget
          onPressed: () {
            // Handle button click
          },
        ),
      ),
    );
  }
}
