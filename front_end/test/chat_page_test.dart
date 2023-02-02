// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:code/chat_page.dart';
import 'package:code/http_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:code/chat_bubble.dart';
import 'package:mockito/mockito.dart';

import 'http_connection_test.mocks.dart';
import 'package:http/http.dart' as http;

void chatPageTest() {

  //verify user bubble letter
  testWidgets('Test for the chat page: connection', (WidgetTester tester) async {
    // Create mock client
    final client = MockClient();

    when(client
        .get(Uri.http("10.0.2.2:5000", "/hello")))
        .thenAnswer((_) async =>
        http.Response('Successful get the greeting', 400));

    const testKey = Key('chat_page');

    // Build a chat page
    await tester.pumpWidget(
        const MaterialApp(
          home: Material(key:testKey,child:ChatPage()),
        )
    );

    // Verify the chat page item
    final contentFinder = find.byKey(testKey);
    expect(contentFinder, findsOneWidget);

    // verify loading bubble
    final iconFinder2 = find.byType(SpinKitThreeBounce);
    expect(iconFinder2, findsOneWidget);

    //wait for the respond
    await tester.pump(const Duration(milliseconds: 100));

    // verify loading bubble
    final iconFinder3 = find.byType(SpinKitThreeBounce);
    expect(iconFinder3, findsNothing);

    // final savedRecordFinder1 = find.descendant(of: savedRecordFinder, matching:find.byType(ListView));
    final savedRecordFinder1 = find.textContaining('400');//test environment only support 400
    expect(savedRecordFinder1, findsOneWidget);
  });

  //verify user bubble letter
  testWidgets('Test for the chat page: save record and show history list', (WidgetTester tester) async {
    // Create mock client
    final client = MockClient();

    when(client
        .get(Uri.http("10.0.2.2:5000", "/hello")))
        .thenAnswer((_) async =>
        http.Response('Successful get the greeting', 400));

    const testKey = Key('chat_page');

    // Build a chat page
    await tester.pumpWidget(
        const MaterialApp(
          home: Material(key:testKey,child:ChatPage()),
        )
    );

    //Verify the list icon
    final iconFinder1 = find.byIcon(Icons.list);
    expect(iconFinder1, findsOneWidget);

    //wait for the respond
    await tester.pump(const Duration(milliseconds: 100));

    //check for the favorite_click button
    final iconFinder4 = find.byIcon(Icons.favorite_border);
    expect(iconFinder4, findsOneWidget);

    //Add a favorite item
    await tester.tap(find.byIcon(Icons.favorite_border));
    await tester.pump();

    //wait for the respond
    await tester.pump(const Duration(milliseconds: 100));

    //open the saved list
    await tester.tap(find.byIcon(Icons.list));
    await tester.pump();

    //wait for the respond
    await tester.pump(const Duration(milliseconds: 100));

    //Find the text
    final savedRecordFinder = find.text('Saved Records');
    expect(savedRecordFinder, findsOneWidget);

    final Iterable<ListTile> savedList1 = ChatBubbleState.getSaved();
    expect(savedList1.length, 1);

    // final savedRecordFinder1 = find.descendant(of: savedRecordFinder, matching:find.byType(ListView));
    final savedRecordFinder1 = find.textContaining('400');//test environment only support 400
    expect(savedRecordFinder1, findsNWidgets(2));
  });

  //verify empty box
  testWidgets('Test for the chat page: empty box', (WidgetTester tester) async {
    // Create mock client
    final client = MockClient();

    when(client
        .get(Uri.http("10.0.2.2:5000", "/hello")))
        .thenAnswer((_) async =>
        http.Response('Successful get the greeting', 400));

    const testKey = Key('chat_page');

    // Build a chat page
    await tester.pumpWidget(
        const MaterialApp(
          home: Material(key: testKey, child: ChatPage()),
        )
    );

    //wait for the respond
    await tester.pump(const Duration(milliseconds: 100));

    //check for text input button
    final iconFinder5 = find.byIcon(Icons.send);
    expect(iconFinder5, findsOneWidget);

    //empty input test
    await tester.enterText(find.byType(TextField), '');
    await tester.tap(iconFinder5);
    await tester.pump(const Duration(milliseconds: 100));
    final emptyErrDialog = find.byType(AlertDialog);
    expect(emptyErrDialog, findsOneWidget);

    final okButtonFinder = find.byType(TextButton);
    expect(okButtonFinder, findsOneWidget);

    await tester.tap(okButtonFinder);
    await tester.pump(const Duration(milliseconds: 100));
    final emptyErrDialog2 = find.byType(AlertDialog);
    expect(emptyErrDialog2, findsNothing);

    final okButtonFinder2 = find.byType(TextButton);
    expect(okButtonFinder2, findsNothing);
  });

  testWidgets('Test for the chat page: generate respond', (WidgetTester tester) async {
    // Create mock client
    final client = MockClient();

    when(client
        .get(Uri.http("10.0.2.2:5000", "/hello")))
        .thenAnswer((_) async =>
        http.Response('Successful get the greeting', 400)); //test environment only support 400

    when(client.post(
        Uri.http("10.0.2.2:5000", "/respond"),
        body: anyNamed('body'),
        headers: anyNamed('headers')
    )
    ).thenAnswer((_) async =>
        http.Response("This is the mock system output.", 400));//test environment only support 400

    const testKey = Key('chat_page');

    // Build a chat page
    await tester.pumpWidget(
        const MaterialApp(
          home: Material(key:testKey,child:ChatPage()),
        )
    );

    //wait for the respond
    await tester.pump(const Duration(milliseconds: 100));

    //check for text input button
    final iconFinder5 = find.byIcon(Icons.send);
    expect(iconFinder5, findsOneWidget);

    //empty input test
    await tester.enterText(find.byType(TextField), 'This is a mock input.');
    await tester.tap(iconFinder5);

    //wait for respond bubble generation
    await tester.pump(const Duration(milliseconds: 100));
    //check for the favorite_click button
    final iconFinder4 = find.byIcon(Icons.favorite_border);
    expect(iconFinder4, findsNWidgets(2));


    //generate respond by submit event
    await tester.enterText(find.byType(TextField), 'This is a mock input 2.');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump(const Duration(milliseconds: 100));

    //check for the favorite_click button
    final iconFinder6 = find.byIcon(Icons.favorite_border);
    expect(iconFinder6, findsNWidgets(3));
  });
}
