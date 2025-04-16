import 'package:flutter/material.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  ExerciseScreenState createState() => ExerciseScreenState();
}

class ExerciseScreenState extends State<ExerciseScreen> {
  // Initialize the list of sets
  List<ExerciseSet> exerciseSets = [
    ExerciseSet(reps: 10, weight: 20.0),
    ExerciseSet(reps: 12, weight: 25.0),
    ExerciseSet(reps: 8, weight: 30.0),
  ];

  // Function to add a new set
  void _addSet() {
    setState(() {
      exerciseSets.add(ExerciseSet(reps: 10, weight: 0.0)); // Default values
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.white,
          scaffoldBackgroundColor: Colors.white,
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: Colors.black,
            selectionColor: Colors.black,
          ),
          inputDecorationTheme: InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.black,
                  width: 1.0), // black border for not focused
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: Colors.black, width: 2.0), // black boder for focused
            ),
          )),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'GymTrackerX',
            style: TextStyle(
              fontSize: 50,
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
                '',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
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
                                // Field for repetitions
                                SizedBox(
                                  width: 80,
                                  child: TextFormField(
                                    initialValue: set.reps.toString(),
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        labelText: 'Reps',
                                        border: OutlineInputBorder(),
                                        enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors
                                                    .black) //here is border color normal
                                            ),
                                        focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.black,
                                                width:
                                                    2.0) //border color when focused
                                            )),
                                    onChanged: (value) {
                                      setState(() {
                                        set.reps =
                                            int.tryParse(value) ?? set.reps;
                                      });
                                    },
                                  ),
                                ),
                                SizedBox(width: 16),
                                // Field for weight
                                SizedBox(
                                  width: 100,
                                  child: TextFormField(
                                    initialValue: set.weight.toString(),
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                    decoration: InputDecoration(
                                      labelText: 'Weight (kg)',
                                      border: OutlineInputBorder(),
                                    ),
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
                    child: Text('Add Set'),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: _addSet,
                    // Timer function to be added later, placeholder for now
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    child: Text('Timer'),
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
  int reps; // Number of repetitions
  double weight; // Weight for the set

  ExerciseSet({required this.reps, required this.weight});
}
