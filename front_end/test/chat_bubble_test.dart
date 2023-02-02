// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:code/chat_bubble.dart';

void chatBubbleTest() {

  //verify user bubble letter
  testWidgets('The chat bubble shows \'This is an user input.\'', (WidgetTester tester) async {
    // Build a bubble
    await tester.pumpWidget(
        const MaterialApp(
          home: Material(child:ChatBubble('This is an user input.', true)),
        )
    );

    // Verify the text
    final contentFinder = find.text('This is an user input.');
    // Verify the icon
    final iconFinder = find.byIcon(Icons.favorite_border);

    expect(contentFinder, findsOneWidget);
    expect(iconFinder, findsNothing);
  });

  //verify the system output shown in the bubble
  testWidgets('The chat bubble shows \'This is a system input.\'', (WidgetTester tester) async {
    // Build a bubble
    await tester.pumpWidget(
        const MaterialApp(
          home: Material(child:ChatBubble('This is a system input.', false)),
        )
    );

    // Verify the text
    final contentFinder = find.text('This is a system input.');
    // Verify the icon
    final iconFinder = find.byIcon(Icons.favorite_border);

    expect(contentFinder, findsOneWidget);
    expect(iconFinder, findsOneWidget);
  });

  testWidgets('Verify add to list function.', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
        const MaterialApp(
          home: Material(child:ChatBubble('A', false)),
        )
    );

    final Iterable<ListTile> savedList = ChatBubbleState.getSaved();
    expect(savedList.length, 0);

    // Tap the favourite_border icon and trigger change the icon
    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();

    //verify icon type
    final iconFinder1 = find.byIcon(Icons.favorite);
    expect(iconFinder1, findsOneWidget);

    //verify getSaved
    final Iterable<ListTile> savedList1 = ChatBubbleState.getSaved();
    expect(savedList1.length, 1);
    expect(savedList1.first, isA<ListTile>());

    // Tap the favourite icon and trigger change the icon
    await tester.tap(find.byIcon(Icons.favorite));
    await tester.pump();

    //verify icon type
    final iconFinder2 = find.byIcon(Icons.favorite);
    expect(iconFinder2, findsNothing);

    final iconFinder3 = find.byIcon(Icons.favorite_border);
    expect(iconFinder3, findsOneWidget);

    //verify getSaved
    final Iterable<ListTile> savedList2 = ChatBubbleState.getSaved();
    expect(savedList2.length, 0);

  });
}
