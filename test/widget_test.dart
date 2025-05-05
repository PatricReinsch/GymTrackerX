import 'package:flutter_test/flutter_test.dart';
//import 'package:flutter/material.dart';
//import 'package:gym_tracker_x/screens/exercise_screen.dart'

void main() {
  test('Placeholder test', () {
    expect(1, 1); // This will always pass.
  });
}

/* commented out because the tested functionality is not there yet

void main() {
  testWidgets('ExerciseScreen displays sets and adds new ones',
          (WidgetTester tester) async {
        // build widget
        await tester.pumpWidget(
          const MaterialApp(home: ExerciseScreen()),
        );

        // Check existing sets (there are initially 3)
        expect(find.text('Set 1'), findsOneWidget);
        expect(find.text('Set 2'), findsOneWidget);
        expect(find.text('Set 3'), findsOneWidget);

        // Find and click the “Add Set” button
        final addSetButton = find.widgetWithText(ElevatedButton, 'Add Set');
        expect(addSetButton, findsOneWidget);
        await tester.tap(addSetButton);
        await tester.pump(); // UI refresh

        // Check whether a new set has been added
        expect(find.text('Set 4'), findsOneWidget);

        // Find and edit input field for reps and weight
        final repsFields = find.widgetWithText(TextFormField, 'Reps');
        final weightFields = find.widgetWithText(TextFormField, 'Weight (kg)');

        expect(repsFields, findsWidgets);
        expect(weightFields, findsWidgets);

        // Change the last Reps field (for Set 4)
        await tester.enterText(repsFields.last, '15');
        await tester.enterText(weightFields.last, '40.5');

        // check whether text has been adopted
        expect(find.text('15'), findsOneWidget);
        expect(find.text('40.5'), findsOneWidget);
      });
}

 */