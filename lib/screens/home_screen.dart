import 'package:flutter/material.dart';
import '../utils/icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'split_screen.dart';
import 'package:gym_tracker_x/services/workout_service.dart';

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
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          // Aligns items at the start
          children: [
            const SizedBox(height: 20),
            InkWell(
              onTap: () async {
                try {
                  // Placeholder: user_id = 1, name = "My First Plan"
                  final newPlanId = await WorkoutService.createWorkoutPlan(3, "My First Plan");
                  print(newPlanId); //TO DO: newPlanId is needed to assign splits to the correct workout_plan in the database
                  // Navigate to SplitScreen with planId
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SplitScreen(planId: 1),
                    ),
                  );
                } catch (e) {
                  print('Error when creating the plan: $e');
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Error when creating the plan')),
                  );
                }
              },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black,
                    width: 4,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Column(
                  children: [
                    Text(
                      "Create your first Plan",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 20),
                    Icon(CustomIcons.addCircleOutlineRounded, size: 60),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
