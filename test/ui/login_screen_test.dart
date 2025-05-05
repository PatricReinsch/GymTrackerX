import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_tracker_x/screens/login_screen.dart';

void main() {
  testWidgets('LoginScreen displays fields and responds correctly to entries',
      (WidgetTester tester) async {
    // Build the widget
    await tester.pumpWidget(const MaterialApp(home: LoginScreen()));

    // Check for the username and password fields
    expect(find.byType(TextField), findsNWidgets(2));
    expect(find.text('Username'), findsOneWidget);
    expect(find.text('Password'), findsOneWidget);

    // Enter username and password
    await tester.enterText(find.byType(TextField).at(0), 'tester');
    await tester.enterText(find.byType(TextField).at(1), '123456');

    // Tap the login button (assumes it's a TextButton with 'Login' text)
    await tester.tap(find.text('Login'));
    await tester.pump(); // rebuild UI after interaction

    // Expect still on the same screen (no navigation happens in test mode)
    expect(find.text('Login'), findsOneWidget);
  });
}
