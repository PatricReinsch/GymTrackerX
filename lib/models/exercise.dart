class Exercise {
  final String exerciseId;
  final String name;
  final String description;
  final int duration;
  final int repetitions;

  Exercise({
    required this.exerciseId,
    required this.name,
    required this.description,
    required this.duration,
    required this.repetitions,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      exerciseId: json['exerciseId'],
      name: json['name'],
      description: json['description'],
      duration: json['duration'],
      repetitions: json['repetitions'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exerciseId': exerciseId,
      'name': name,
      'description': description,
      'duration': duration,
      'repetitions': repetitions,
    };
  }
}
