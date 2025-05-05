import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gym_tracker_x/screens/login_screen.dart';
import 'package:gym_tracker_x/widgets/custom_button_black.dart';

void main() {
  testWidgets('LoginScreen displays fields and responds correctly to entries',
      (WidgetTester tester) async {
    // render LoginScreen
    await tester.pumpWidget(
      const MaterialApp(
        home: LoginScreen(),
      ),
    );

    // find text boxes
    final usernameField = find.widgetWithText(TextField, 'Username');
    final passwordField = find.widgetWithText(TextField, 'Password');
    final loginButton = find.byType(CustomButtonBlack);

    // check existency
    expect(usernameField, findsOneWidget);
    expect(passwordField, findsOneWidget);
    expect(loginButton, findsOneWidget);

    // Test case: Empty fields => should display errors
    await tester.tap(loginButton);
    await tester.pump();

    expect(find.text('Invalid username or password'), findsOneWidget);

    // Test case: Entering data
    await tester.enterText(usernameField, 'tester');
    await tester.enterText(passwordField, '123456');

    expect(find.text('tester'), findsOneWidget);
    expect(find.text('123456'), findsOneWidget);

    // press login again
    await tester.tap(loginButton);
    await tester.pump(); // pump() required for async behavior
  });
}
