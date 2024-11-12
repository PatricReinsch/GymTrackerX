import 'package:flutter/material.dart';
import 'package:gym_tracker_x/widgets/app_bar_title.dart';
import 'package:gym_tracker_x/widgets/custom_button.dart';
import 'split_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const AppBarTitle(title: "Gym Tracker"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(
              label: "Create your first Plan",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SplitScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
