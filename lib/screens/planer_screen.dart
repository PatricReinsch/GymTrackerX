import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'home_screen.dart';
import 'package:gym_tracker_x/services/split_service.dart';

class PlanerScreen extends StatefulWidget {
  final int planId;
  final int totalSplits;
  final int currentSplitIndex;

  const PlanerScreen({
    super.key,
    required this.planId,
    required this.totalSplits,
    required this.currentSplitIndex,
  });

  @override
  PlanerScreenState createState() => PlanerScreenState();
}

class PlanerScreenState extends State<PlanerScreen> {
  TextEditingController searchController = TextEditingController();
  TextEditingController splitNameController = TextEditingController();

  List<Map<String, dynamic>> exercises = [
    {"id": 1, "name": "Leg Press"},
    {"id": 2, "name": "Squats"},
    {"id": 3, "name": "Deadlift"},
    {"id": 4, "name": "Bench Press"},
    {"id": 5, "name": "Shoulder Press"},
    {"id": 6, "name": "Bicep Curls"},
    {"id": 7, "name": "Tricep Extensions"},
    {"id": 8, "name": "Lunges"},
    {"id": 9, "name": "Pull-ups"},
  ];

  List<Map<String, String>> selectedExercises = [];

  List<String> setsOptions = ['1', '2', '3', '4', '5'];
  List<String> frequencyOptions =
      List.generate(13, (index) => (5 + index).toString());

  void addExercise(Map<String, dynamic> exercise) {
    setState(() {
      selectedExercises.add({
        'exercise_id': exercise['id'].toString(),
        'exercise_name': exercise['name'],
        'weight': '',
        'sets': setsOptions[0],
        'frequency': frequencyOptions[0],
      });
    });
  }

  void updateExercise(int index, String field, String value) {
    setState(() {
      selectedExercises[index][field] = value;
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(40),
                    border: Border.all(
                      color: Colors.black,
                      width: 4,
                    ),
                  ),
                  child: TextField(
                    controller: splitNameController,
                    decoration: const InputDecoration(
                      hintText: 'Split Name',
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  )),
              const SizedBox(height: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color: Colors.black,
                    width: 4,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Expanded(
                          flex: 3,
                          child: Text(
                            'Name',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Weight',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'Sets',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Text(
                            'X',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Column(
                      children: selectedExercises.map((exerciseData) {
                        int index = selectedExercises.indexOf(exerciseData);
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 3,
                                  child: Text(
                                    exerciseData['exercise_name']!,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 17),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade400,
                                      borderRadius: BorderRadius.circular(40),
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 4,
                                      ),
                                    ),
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      decoration: const InputDecoration(
                                        hintText: 'Weight',
                                        hintStyle:
                                            TextStyle(color: Colors.black),
                                        border: InputBorder.none,
                                      ),
                                      onChanged: (value) {
                                        updateExercise(index, 'weight', value);
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  flex: 1,
                                  child: DropdownButton<String>(
                                    value: exerciseData['sets'],
                                    onChanged: (value) {
                                      updateExercise(index, 'sets', value!);
                                    },
                                    items: setsOptions.map((String sets) {
                                      return DropdownMenuItem<String>(
                                        value: sets,
                                        child: Text(sets),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: DropdownButton<String>(
                                    value: exerciseData['frequency'],
                                    onChanged: (value) {
                                      updateExercise(
                                          index, 'frequency', value!);
                                    },
                                    items: frequencyOptions.map((String freq) {
                                      return DropdownMenuItem<String>(
                                        value: freq,
                                        child: Text(freq),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              height: 4,
                              color: Colors.black,
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                decoration: BoxDecoration(
                  color: Colors.grey.shade400,
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color: Colors.black,
                    width: 4,
                  ),
                ),
                child: TextField(
                  controller: searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search',
                    hintStyle: TextStyle(
                      color: Colors.black,
                    ),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color: Colors.black,
                    width: 4,
                  ),
                ),
                child: ListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  children: exercises
                      .where((exercise) => exercise['name']
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase()))
                      .map((exercise) {
                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            addExercise(exercise);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: Text(
                              exercise['name'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 4,
                          color: Colors.black,
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 140),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color: Colors.black,
                    width: 4,
                  ),
                ),
                child: TextButton(
                  onPressed: () async {
                    final splitName = splitNameController.text.trim();
                    if (splitName.isEmpty || selectedExercises.isEmpty) return;

                    // 1. save split
                    final splitId = await SplitService.createSplit(
                        widget.planId, splitName);

                    // 2. save exercises
                    for (var exercise in selectedExercises) {
                      await SplitService.addExerciseToSplit(
                        splitId,
                        int.parse(exercise['exercise_id']!),
                        // ✅ richtiges Feld & Typ
                        exercise['weight']!,
                        int.parse(exercise['sets']!),
                        int.parse(exercise['frequency']!),
                      );
                    }

                    // 3. create next split or finish and go back to home screen
                    if (widget.currentSplitIndex + 1 < widget.totalSplits) {
                      if (!context.mounted) return;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PlanerScreen(
                            planId: widget.planId,
                            totalSplits: widget.totalSplits,
                            currentSplitIndex: widget.currentSplitIndex + 1,
                          ),
                        ),
                      );
                    } else {
                      if (!context.mounted) return;
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                        (route) => false,
                      );
                    }
                  },
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
