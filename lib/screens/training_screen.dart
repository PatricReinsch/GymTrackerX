import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gym_tracker_x/screens/exercise_screen.dart';
import 'package:gym_tracker_x/widgets/custom_button_black.dart';
import 'package:gym_tracker_x/widgets/custom_button_grey.dart';

class TrainingScreen extends StatelessWidget {
  const TrainingScreen({super.key});
  Widget _buildRow(BuildContext context, String text, Color color, String route) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Container(
        color: color,
        padding: EdgeInsets.symmetric(vertical: 8),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

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
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // Aligns items at the start
          children: [
            Text(
              "Push",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildRow(context, 'Leg Press', Colors.green, '/exercisescreen'),
                  Divider(color: Colors.black, height: 1, thickness: 1),
                  _buildRow(context, 'Curls', Colors.green, '/exercisescreen'),
                  Divider(color: Colors.black, height: 1, thickness: 1),
                  _buildRow(context, '1234', Colors.green, '/exercisescreen'),
                  Divider(color: Colors.black, height: 1, thickness: 1),
                  _buildRow(context, '5674', Colors.red, '/exercisescreen'),
                  Divider(color: Colors.black, height: 1, thickness: 1),
                  _buildRow(context, '19323', Colors.white, '/exercisescreen'),
                ],
              ),
            ),
            const SizedBox(height: 25),
            // Timer
            CustomButtonGrey(label: "Timer",
                onPressed: () { //TO DO: add logic
                }
            ),
            const SizedBox(height: 40),
            // Finish Button
            CustomButtonBlack(label: "Finish",
                onPressed: () { //TO DO: add logic
                }
            ),
          ],
        ),
      ),
    );
  }
}
