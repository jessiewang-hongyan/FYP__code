// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:convert';

import 'package:code/http_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'http_connection_test.mocks.dart';

@GenerateMocks([http.Client])
void httpConnectionTest() {
  group("", (){
    // test("Return greeting msg.", (){
    //   final client = MockClient();
    //
    //   when(client
    //       .get(Uri.http("10.0.2.2:5000", "/hello")))
    //       .thenAnswer((_) async =>
    //       http.Response('Successful get the greeting', 200));
    //
    //   expect(requestGreeting(), isA<Future<String>>());
    // });

    test("Return greeting fail.", (){
      final client = MockClient();

      when(client
          .get(Uri.http("10.0.2.2:5000", "/hello")))
          .thenAnswer((_) async =>
          http.Response('Not found', 404));
      requestGreeting().then((msg){
        expect(msg, 'Request failed.Exception: 400');
      });

    });

    // test("Return respond msg.", (){
    //   final client = MockClient();
    //
    //   when(client.post(
    //       Uri.http("10.0.2.2:5000", "/respond"),
    //       body: anyNamed('body'),
    //       headers: anyNamed('headers')
    //     )
    //   ).thenAnswer((_) async =>
    //       http.Response("This is the mock system output.", 200));
    //
    //   expect(postInput("I'm mock user input."), isA<Future<String>>());
    // });

    test("Return respond fail.", (){
      final client = MockClient();

      when(client.post(Uri.http("10.0.2.2:5000", "/respond")))
          .thenAnswer((_) async =>
          http.Response('Not Found', 404));
      postInput("I'm mock user input.").then((msg){
        expect(msg, "Failed to get respond string. Exception: 400");
      });
    });
  });
}
