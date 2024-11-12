class Split {
  final String splitId;
  final String name;
  final String description;
  final List<String> workoutIds;

  Split({
    required this.splitId,
    required this.name,
    required this.description,
    required this.workoutIds,
  });

  factory Split.fromJson(Map<String, dynamic> json) {
    return Split(
      splitId: json['splitId'],
      name: json['name'],
      description: json['description'],
      workoutIds: List<String>.from(json['workoutIds']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'splitId': splitId,
      'name': name,
      'description': description,
      'workoutIds': workoutIds,
    };
  }
}
