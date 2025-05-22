import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:gym_tracker_x/utils/logger.dart';

class WorkoutService {
  static const String baseUrl = "http://10.0.2.2:5000/api"; //backend URL

  static Future<int?> createWorkoutPlan(int userId, String name) async {
    final url = Uri.parse('$baseUrl/workouts');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': userId,
          'name': name,
        }),
      );

      if (response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data['id']; // ID of the new plan
      } else {
        logger.e('Error when creating the plan: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      logger.e('Network error when creating the plan: $e');
      return null;
    }
  }
}
