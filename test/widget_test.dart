import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:untitled1/main.dart';

 // Replace 'your_calculator_app' with the actual import path

void main() {
  testWidgets('Calculator functionality test', (WidgetTester tester) async {
    // Build your app.
    await tester.pumpWidget(CalculatorApp());

    // Verify that the initial output is '0'.
    expect(find.text('0'), findsOneWidget);

    // Test addition operation.
    await tester.tap(find.text('1'));
    await tester.tap(find.text('+'));
    await tester.tap(find.text('2'));
    await tester.tap(find.text('='));
    await tester.pump();
    expect(find.text('3'), findsOneWidget);

    // Test subtraction operation.
    await tester.tap(find.text('3'));
    await tester.tap(find.text('-'));
    await tester.tap(find.text('1'));
    await tester.tap(find.text('='));
    await tester.pump();
    expect(find.text('2'), findsOneWidget);

    // Test multiplication operation.
    await tester.tap(find.text('2'));
    await tester.tap(find.text('*'));
    await tester.tap(find.text('4'));
    await tester.tap(find.text('='));
    await tester.pump();
    expect(find.text('8'), findsOneWidget);

    // Test division operation.
    await tester.tap(find.text('8'));
    await tester.tap(find.text('/'));
    await tester.tap(find.text('2'));
    await tester.tap(find.text('='));
    await tester.pump();
    expect(find.text('4'), findsOneWidget);

    // Test clearing the calculator.
    await tester.tap(find.text('C'));
    await tester.pump();
    expect(find.text('0'), findsOneWidget);
  });
}
