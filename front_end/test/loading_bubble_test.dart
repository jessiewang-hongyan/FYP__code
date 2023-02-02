// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:code/loading_bubble.dart';

void loadBubbleTest() {

  //verify user bubble letter
  testWidgets('The chat bubble shows loading animation.', (WidgetTester tester) async {
    // Build a bubble
    await tester.pumpWidget(
        const MaterialApp(
          home: Material(child:LoadBubble()),
        )
    );

    // Verify the text
    final contentFinder = find.byType(SpinKitThreeBounce);
    expect(contentFinder, findsOneWidget);
  });

}
