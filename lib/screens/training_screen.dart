import 'dart:async';

//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gym_tracker_x/widgets/custom_button_black.dart';

class TrainingScreen extends StatefulWidget {
  const TrainingScreen({super.key});

  @override
  TrainingScreenState createState() => TrainingScreenState();
}

class TrainingScreenState extends State<TrainingScreen> {
  int hours = 0;
  int minutes = 0;
  int seconds = 0;
  bool isRunning = false;
  Timer? timer;
  Duration remainingTime = Duration();

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
                  _buildRow(
                      context, 'Leg Press', Colors.green, '/exercisescreen'),
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
            // Timer UI
            Container(
              width: 300,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Column(
                children: [
                  Text(
                    "Timer",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildPicker(
                        "H",
                        24,
                        hours,
                        (value) {
                          setState(() {
                            hours = value;
                          });
                        },
                      ),
                      _buildPicker(
                        "M",
                        60,
                        minutes,
                        (value) {
                          setState(() {
                            minutes = value;
                          });
                        },
                      ),
                      _buildPicker(
                        "S",
                        60,
                        seconds,
                        (value) {
                          setState(() {
                            seconds = value;
                          });
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "${remainingTime.inHours.toString().padLeft(2, '0')}:${(remainingTime.inMinutes % 60).toString().padLeft(2, '0')}:${(remainingTime.inSeconds % 60).toString().padLeft(2, '0')}",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
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
                        icon: Icon(Icons.stop),
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
            CustomButtonBlack(label: "Finish", onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(
      BuildContext context, String text, Color color, String route) {
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

  Widget _buildPicker(
      String label, int max, int selectedValue, ValueChanged<int> onChanged) {
    return Expanded(
      child: Column(
        children: [
          Text(label,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          SizedBox(
            height: 150,
            child: ListWheelScrollView.useDelegate(
              physics: const FixedExtentScrollPhysics(),
              itemExtent: 48,
              onSelectedItemChanged: (index) {
                int actualValue = index % max;
                if (actualValue < 0) {
                  actualValue += max;
                }
                onChanged(actualValue);
              },
              controller:
                  FixedExtentScrollController(initialItem: max + selectedValue),
              childDelegate: ListWheelChildBuilderDelegate(
                builder: (context, index) {
                  int value = index % max;
                  if (value < 0) value += max;
                  bool isSelected = value == selectedValue;
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
