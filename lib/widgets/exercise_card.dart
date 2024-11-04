import 'package:flutter/material.dart';

class ExerciseCard extends StatelessWidget {
  final String name;
  final String description;
  final int duration; // in seconds
  final int repetitions;

  const ExerciseCard({
    super.key,
    required this.name,
    required this.description,
    required this.duration,
    required this.repetitions,
  });

  @override
  Widget build(BuildContext context) {
    return const Card(
        // TODO: Implement
        );
  }
}
