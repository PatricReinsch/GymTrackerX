import 'package:flutter/material.dart';
import '../utils/icons.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        title: SvgPicture.asset(
          'assets/images/logo/svg/logo-no-background.svg',
          height: 65,
          fit: BoxFit.cover,
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Text(
              "Create your first Plan",
              style: TextStyle(
                fontSize: 30, // Change this value to adjust font size
                fontWeight: FontWeight.bold, // Optional: Make text bold
                color: Colors.black, // Optional: Change text color
              ),
            ),
            SizedBox(height: 20),
            Icon(CustomIcons.addCircleOutlineRounded, size: 60),
            // Custom icon
          ],
        ),
      ),
    );
  }
}
