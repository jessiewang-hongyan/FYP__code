import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:code/chat_bubble.dart';

import 'chat_bubble_test.dart';
import 'chat_page_test.dart';
import 'http_connection_test.dart';
import 'loading_bubble_test.dart';
import 'main_test.dart';

void  main(){
  chatBubbleTest();
  loadBubbleTest();

  //httpClient only works with mobile environments
  //so after integrate web, please do not use httpConnectionTest.dart
  //this test is designed for implementation in http_connection_old.dart
  //if you wish to test, please change http_connection.dart with http_connection_old.dart
  httpConnectionTest();

  chatPageTest();
  mainTest();
}