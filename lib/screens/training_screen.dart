import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gym_tracker_x/screens/exercise_screen.dart';
import 'package:gym_tracker_x/services/workout_service.dart';
import 'package:gym_tracker_x/widgets/custom_button_black.dart';

class TrainingScreen extends StatefulWidget {
  final int splitId;
  final String splitName;

  const TrainingScreen({
    super.key,
    required this.splitId,
    required this.splitName,
  });

  @override
  TrainingScreenState createState() => TrainingScreenState();
}

class TrainingScreenState extends State<TrainingScreen> {
  List<Map<String, dynamic>> exercises = [];
  Set<int> completedExerciseIndices = {}; // Track finished exercises

  // Timer
  Duration elapsedTime = Duration.zero;
  Timer? timer;
  bool isRunning = false;

  @override
  void initState() {
    super.initState();
    _loadExercises();
  }

  Future<void> _loadExercises() async {
    try {
      final fetched =
          await WorkoutService.fetchExercisesForSplit(widget.splitId);
      setState(() {
        exercises = fetched;
      });
    } catch (e) {
      // handle error
    }
  }

  void _startTimer() {
    if (!isRunning) {
      setState(() {
        isRunning = true;
      });

      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          elapsedTime += const Duration(seconds: 1);
        });
      });
    }
  }

  void _pauseTimer() {
    timer?.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void _resetTimer() {
    timer?.cancel();
    setState(() {
      isRunning = false;
      elapsedTime = Duration.zero;
    });
  }

  void _navigateToExerciseScreen(int index) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ExerciseScreen(
          exercise: exercises[index],
        ),
      ),
    );

    setState(() {
      completedExerciseIndices.add(index);
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 150,
        centerTitle: true,
        title: SvgPicture.asset(
          'assets/images/logo/svg/logo-no-background.svg',
          height: 65,
          fit: BoxFit.cover,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              widget.splitName,
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            // List of Exercises
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Column(
                children: exercises.asMap().entries.map((entry) {
                  final index = entry.key;
                  final exercise = entry.value;
                  final isCompleted = completedExerciseIndices.contains(index);

                  return InkWell(
                    onTap: () => _navigateToExerciseScreen(index),
                    child: Container(
                      color: isCompleted ? Colors.green[100] : null,
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      child: Row(
                        children: [
                          const Icon(Icons.fitness_center,
                              color: Colors.black87),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  exercise['name'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "${exercise['sets']} sets x ${exercise['reps']} reps – ${exercise['weight']} kg",
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 30),

            // Timer
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Column(
                children: [
                  const Text(
                    "Timer",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "${elapsedTime.inHours.toString().padLeft(2, '0')}:${(elapsedTime.inMinutes % 60).toString().padLeft(2, '0')}:${(elapsedTime.inSeconds % 60).toString().padLeft(2, '0')}",
                    style: const TextStyle(
                        fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: isRunning ? _pauseTimer : _startTimer,
                        icon: Icon(isRunning ? Icons.pause : Icons.play_arrow),
                        color: Colors.black,
                        iconSize: 40,
                      ),
                      IconButton(
                        onPressed: _resetTimer,
                        icon: const Icon(Icons.stop),
                        color: Colors.red,
                        iconSize: 40,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Finish Button
            CustomButtonBlack(
              label: "Finish",
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
