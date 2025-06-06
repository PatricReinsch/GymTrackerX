import 'package:flutter/material.dart';

class ExerciseScreen extends StatefulWidget {
  final Map<String, dynamic> exercise;

  const ExerciseScreen({super.key, required this.exercise});

  @override
  ExerciseScreenState createState() => ExerciseScreenState();
}

class ExerciseScreenState extends State<ExerciseScreen> {
  List<ExerciseSet> exerciseSets = [];

  @override
  void initState() {
    super.initState();

    // Initialisiere Sets basierend auf den übergebenen Übungsdaten
    final sets = int.tryParse(widget.exercise['sets'].toString()) ?? 3;
    final reps = int.tryParse(widget.exercise['reps'].toString()) ?? 10;
    final weight = double.tryParse(widget.exercise['weight'].toString()) ?? 0.0;

    exerciseSets = List.generate(
      sets,
      (_) => ExerciseSet(reps: reps, weight: weight),
    );
  }

  void _addSet() {
    setState(() {
      exerciseSets.add(ExerciseSet(reps: 10, weight: 0.0)); // Default
    });
  }

  @override
  Widget build(BuildContext context) {
    final exercise = widget.exercise;

    return Theme(
      data: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.black,
          selectionColor: Colors.black,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2.0),
          ),
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            exercise['name'] ?? 'Übung',
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${exercise['sets']} sets x ${exercise['reps']} reps – ${exercise['weight']} kg",
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: exerciseSets.length,
                  itemBuilder: (context, index) {
                    final set = exerciseSets[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Set ${index + 1}'),
                            Row(
                              children: [
                                SizedBox(
                                  width: 80,
                                  child: TextFormField(
                                    initialValue: set.reps.toString(),
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                        labelText: 'Reps'),
                                    onChanged: (value) {
                                      setState(() {
                                        set.reps =
                                            int.tryParse(value) ?? set.reps;
                                      });
                                    },
                                  ),
                                ),
                                const SizedBox(width: 16),
                                SizedBox(
                                  width: 100,
                                  child: TextFormField(
                                    initialValue: set.weight.toString(),
                                    keyboardType:
                                        const TextInputType.numberWithOptions(
                                            decimal: true),
                                    decoration: const InputDecoration(
                                        labelText: 'Weight (kg)'),
                                    onChanged: (value) {
                                      setState(() {
                                        set.weight = double.tryParse(value) ??
                                            set.weight;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _addSet,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text('Add Set'),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, true); // signalisiere Erfolg
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: const Text('Done'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ExerciseSet {
  int reps;
  double weight;

  ExerciseSet({required this.reps, required this.weight});
}
