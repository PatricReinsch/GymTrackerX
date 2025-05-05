import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_tracker_x/screens/register_screen.dart';
import 'package:gym_tracker_x/widgets/custom_button_black.dart';

void main() {
  testWidgets('RegisterScreen zeigt Felder an und reagiert auf Eingaben',
          (WidgetTester tester) async {
        // build widget
        await tester.pumpWidget(
          const MaterialApp(
            home: RegisterScreen(),
          ),
        );

        // Check whether text fields are available
        expect(find.byType(TextField), findsNWidgets(2));
        expect(find.widgetWithText(TextField, 'Username'), findsOneWidget);
        expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);

        // Simulate input in text fields
        await tester.enterText(find.widgetWithText(TextField, 'Username'), 'testuser');
        await tester.enterText(find.widgetWithText(TextField, 'Password'), 'testpass');

        // Check whether entries have been accepted
        expect(find.text('testuser'), findsOneWidget);
        expect(find.text('testpass'), findsOneWidget);

        // Test empty fields: simulate empty entries and press button
        await tester.enterText(find.widgetWithText(TextField, 'Username'), '');
        await tester.enterText(find.widgetWithText(TextField, 'Password'), '');

        await tester.tap(find.byType(CustomButtonBlack)); // "Register"-Button
        await tester.pump(); // Snack bar needs pump()

        // Snack bar with error message is expected
        expect(find.text('Username and password cannot be empty.'), findsOneWidget);
      });
}
