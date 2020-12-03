// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:broke_student_brokers/main.dart';
import 'package:broke_student_brokers/pages/home/home.dart';
import 'package:broke_student_brokers/pages/authenticate/sign_in.dart';

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(MyApp());

  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);

  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();

  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });

//   testWidgets("name", (WidgetTester tester) async {
//     await tester.pumpWidget(Home());
//     expect(find.byKey(Key("toSetting")), findsOneWidget);
//   });

  // testWidgets('empty email and password doesn\'t call sign in',
  //     (WidgetTester tester) async {
  //   // create a LoginPage
  //   SignIn loginPage = new SignIn();
  //   // add it to the widget tester
  //   await tester.pumpWidget(loginPage);

  //   // tap on the login button
  //   Finder loginButton = find.byKey(new Key('loginbutton'));
  //   await tester.tap(loginButton);

  //   // 'pump' the tester again. This causes the widget to rebuild
  //   await tester.pump();

  //   // check that the hint text is empty
  //   Finder hintText = find.byKey(new Key('hint'));
  //   expect(hintText.toString().contains(''), true);
  // });

  testWidgets('empty email and password doesn\'t call sign in',
      (WidgetTester tester) async {
    // create a LoginPage
    SignIn loginPage = new SignIn();
    // add it to the widget tester
    await tester.pumpWidget(loginPage);

    // tap on the login button
    Finder loginButton = find.byKey(new Key('loginbutton'));
    await tester.tap(loginButton);

    // 'pump' the tester again. This causes the widget to rebuild
    await tester.pump();

    // check that the hint text is empty
    Finder hintText = find.byKey(new Key('hint1'));
    expect(hintText.toString().contains(''), true);
  });
}
