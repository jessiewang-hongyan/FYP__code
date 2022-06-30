# code

This is the front-end code implementation of my Final Year Project.


## Getting Started

For the settings of Flutter and Android Emulator, please refer to the official docs.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Execution

The entry of the execution is lib/main.dart.

For execution, when running the localhost as the server, 
please notice that the default addresses for localhost in web and Android are different.

For Android, please use 10.0.2.2.

For web, please use 127.0.0.1.

You may find the codes for this setting at http_connection.dart. 

If the server is not local, the address should be the same for both platforms.

## Testing

To begin with, please set the test configuration.

The entry to all coverage tests is test/all_test.dart.

Before test, please replace the contents of http_connection.dart with http_connection_old.dart.

http_connection_old.dart adopts HttpClient, which is compatible with the testing environment. 
