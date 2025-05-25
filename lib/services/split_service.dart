import 'dart:convert';
import 'package:http/http.dart' as http;

class SplitService {
  static const String baseUrl = "http://10.0.2.2:5000/api";

  static Future<int> createSplit(int planId, String name) async {
    final response = await http.post(
      Uri.parse('$baseUrl/splits'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"plan_id": planId, "name": name}),
    );

    if (response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return data['id'];
    } else {
      throw Exception(
          'Failed to create split: ${response.statusCode} - ${response.body}');
    }
  }

  static Future<void> addExerciseToSplit(
    int splitId,
    int exerciseId,
    String weight,
    int sets,
    int reps,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/split-exercises'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "split_id": splitId,
        "exercise_id": exerciseId,
        "weight": weight,
        "sets": sets,
        "reps": reps,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception(
          'Failed to add exercise to split: ${response.statusCode} - ${response.body}');
    }
  }

  static Future<List<Map<String, dynamic>>> fetchExercisesForSplit(
      int splitId) async {
    final response =
        await http.get(Uri.parse('$baseUrl/splits/$splitId/exercises'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.cast<Map<String, dynamic>>();
    } else {
      throw Exception('Failed to load exercises for split');
    }
  }
}
