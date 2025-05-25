import 'package:flutter/material.dart';
import '../utils/icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'split_screen.dart';
import 'package:gym_tracker_x/services/workout_service.dart';
import 'package:gym_tracker_x/utils/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> workoutPlans = [];

  @override
  void initState() {
    super.initState();
    _loadWorkoutPlans();
  }

  Future<int?> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('user_id');
  }

  Future<void> _loadWorkoutPlans() async {
    final userId = await _getUserId();
    if (userId == null) return;

    try {
      final plans = await WorkoutService.fetchWorkoutPlansWithSplits(userId);
      setState(() {
        workoutPlans = plans;
      });
    } catch (e) {
      logger.e('Error when loading the plans: $e');
    }
  }

  void _showCreatePlanDialog(BuildContext context) {
    final TextEditingController _controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Name your workout plan'),
          content: TextField(
            controller: _controller,
            autofocus: true,
            decoration: const InputDecoration(
              hintText: 'e.g. Push/Pull/Legs Plan',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final name = _controller.text.trim();
                if (name.isEmpty) return;

                Navigator.pop(context); // Close dialog
                await _createNewPlan(context, name); // Use name
              },
              child: const Text('Continue'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _createNewPlan(BuildContext context, String name) async {
    try {
      final userId = await _getUserId();
      if (userId == null) throw Exception('User not logged in');

      final newPlanId = await WorkoutService.createWorkoutPlan(userId, name);
      if (newPlanId == null)
        throw Exception('Workout plan could not be created');

      if (!context.mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SplitScreen(planId: newPlanId),
        ),
      );
    } catch (e) {
      logger.e('Error when creating the plan: $e');
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error when creating the plan')),
      );
    }
  }

  Widget _buildWorkoutCard(Map<String, dynamic> plan) {
    final List<dynamic> splits = plan['splits'] ?? [];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            plan['name'],
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 20),
          ...splits.map((split) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    const Icon(Icons.fitness_center,
                        size: 18, color: Colors.black54),
                    const SizedBox(width: 8),
                    Text(
                      split['name'],
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )),
        ],
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            InkWell(
              onTap: () => _showCreatePlanDialog(context),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                margin: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black, width: 4),
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
                      "Create Workout Plan",
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
            const SizedBox(height: 20),
            ...workoutPlans.map(_buildWorkoutCard),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
