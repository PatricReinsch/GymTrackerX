import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  // Timer
  int hours = 0;
  int minutes = 0;
  int seconds = 0;
  bool isRunning = false;
  Timer? timer;
  Duration remainingTime = Duration.zero;

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
        if (remainingTime.inSeconds == 0) {
          remainingTime =
              Duration(hours: hours, minutes: minutes, seconds: seconds);
        }
        isRunning = true;
      });

      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (remainingTime.inSeconds > 0) {
          setState(() {
            remainingTime -= const Duration(seconds: 1);
          });
        } else {
          timer.cancel();
          setState(() {
            isRunning = false;
          });
        }
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
      remainingTime = Duration.zero;
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
                children: exercises.map((exercise) {
                  return Column(
                    children: [
                      Container(
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
                      const Divider(color: Colors.black, height: 1),
                    ],
                  );
                }).toList(),
              ),
            ),

            const SizedBox(height: 30),

            // Timer UI
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildPicker(
                          "H", 24, hours, (val) => setState(() => hours = val)),
                      _buildPicker("M", 60, minutes,
                          (val) => setState(() => minutes = val)),
                      _buildPicker("S", 60, seconds,
                          (val) => setState(() => seconds = val)),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "${remainingTime.inHours.toString().padLeft(2, '0')}:${(remainingTime.inMinutes % 60).toString().padLeft(2, '0')}:${(remainingTime.inSeconds % 60).toString().padLeft(2, '0')}",
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

  Widget _buildPicker(
      String label, int max, int selected, ValueChanged<int> onChanged) {
    return Expanded(
      child: Column(
        children: [
          Text(label,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 150,
            child: ListWheelScrollView.useDelegate(
              physics: const FixedExtentScrollPhysics(),
              itemExtent: 48,
              onSelectedItemChanged: (index) {
                int val = index % max;
                onChanged(val < 0 ? val + max : val);
              },
              controller:
                  FixedExtentScrollController(initialItem: max + selected),
              childDelegate: ListWheelChildBuilderDelegate(
                builder: (context, index) {
                  int value = index % max;
                  value = value < 0 ? value + max : value;
                  bool isSelected = value == selected;
                  return Center(
                    child: Text(
                      value.toString().padLeft(2, '0'),
                      style: TextStyle(
                        fontSize: isSelected ? 40 : 24,
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        color: isSelected ? Colors.black : Colors.blueGrey,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
