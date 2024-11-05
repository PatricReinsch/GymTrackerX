class Workout {
  final String workoutId;
  final String title;
  final String description;
  final List<String> exerciseIds;

  Workout({
    required this.workoutId,
    required this.title,
    required this.description,
    required this.exerciseIds,
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      workoutId: json['workoutId'],
      title: json['title'],
      description: json['description'],
      exerciseIds: List<String>.from(json['exerciseIds']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'workoutId': workoutId,
      'title': title,
      'description': description,
      'exerciseIds': exerciseIds,
    };
  }
}
