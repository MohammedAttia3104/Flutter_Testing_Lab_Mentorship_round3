import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/widgets/user_registration_form.dart';

void main() {
  testWidgets('UserRegistrationForm validation and submit', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
    );

    await tester.tap(find.text('Register'));
    await tester.pump();

    expect(find.text('Please enter your full name'), findsOneWidget);
    expect(find.text('Please enter your email'), findsOneWidget);
    expect(find.text('Please enter a password'), findsOneWidget);
    expect(find.text('Please confirm your password'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'Mohamed');
    await tester.enterText(
      find.byType(TextFormField).at(1),
      'attia3104@gmail.com',
    );
    await tester.enterText(find.byType(TextFormField).at(2), 'Password123@@');
    await tester.enterText(find.byType(TextFormField).at(3), 'Password123@@');

    await tester.tap(find.text('Register'));
    await tester.pump();

    ///loading
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    ///error
    expect(
      find.text('Please fix the errors in red before submitting.'),
      findsNothing,
    );

    await tester.pumpAndSettle();

    ///success
    expect(find.text('Registration successful!'), findsOneWidget);
  });
}
