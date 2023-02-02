// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:code/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_test/flutter_test.dart';

void mainTest() {

  //verify user bubble letter
  testWidgets('runApp methond test', (WidgetTester tester) async {
    // Build a bubble
    await tester.pumpWidget(MyApp());

    // Verify the text
    final contentFinder = find.byType(MyApp);
    expect(contentFinder, findsOneWidget);
  });

  //verify user bubble letter
  testWidgets('main test', (WidgetTester tester) async {

    main();
    // Build a bubble
    await tester.pump(const Duration(milliseconds: 100));

    // Verify the text
    final contentFinder = find.byType(MyApp);
    expect(contentFinder, findsOneWidget);
  });

}
