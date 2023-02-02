import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

//server address for localhost testing is 10.0.2.2
var greetingUri = Uri.http("10.0.2.2:5000", "/hello");
var queryUri = Uri.http("10.0.2.2:5000", "/respond");


//send request
Future<String> requestGreeting() async {
  var _loading = true;
  var _text = "Requesting...";

  try {
    HttpClient httpClient = HttpClient();
    // Client httpClient = Client();
    HttpClientRequest request = await httpClient.getUrl(greetingUri);

    // request.headers.add(
    //   "user-agent",
    //   "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1",
    // );

    HttpClientResponse response = await request.close();

    _text = await response.transform(utf8.decoder).join();

    if (response.statusCode != 200) {
      throw Exception(response.statusCode);
    }

    httpClient.close();
    return _text;
  } catch (e) {
    return "Request failed.$e";
  }
}

Future<String> postInput(String inputStr) async {
  try {
    HttpClient httpClient = HttpClient();
    // Client httpClient = Client();

    HttpClientRequest request = await httpClient.postUrl(queryUri);
    request.headers.add('Content-Type', 'application/json; charset=UTF-8');
    request.write(jsonEncode(<String, String>{
      'input': inputStr,
    }));

    HttpClientResponse response = await request.close();

    if (response.statusCode != 200) {
      throw Exception(response.statusCode);
    }

    httpClient.close();
    return response.transform(utf8.decoder).join();

  } catch(e) {
    return 'Failed to get respond string. $e';
  }
}

// Future<String> request(String inputStr) async {
//   var _loading = true;
//   var _text = "正在请求...";
//
//   try {
//     //创建一个HttpClient
//     HttpClient httpClient = HttpClient();
//
//     //打开Http连接
//     HttpClientRequest request = await httpClient.getUrl(queryUri);
//     //使用iPhone的UA
//     request.headers.add(
//       "user-agent",
//       "Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304 Safari/602.1",
//     );
//     //等待连接服务器（会将请求信息发送给服务器）
//     HttpClientResponse response = await request.close();
//     //读取响应内容
//     _text = await response.transform(utf8.decoder).join();
//
//     //输出响应头
//     print(response.headers);
//
//     //关闭client后，通过该client发起的所有请求都会中止。
//     httpClient.close();
//   } catch (e) {
//     _text = "Request failed：$e";
//   } finally {
//     _loading = false;
//
//     print(_text);
//     return _text + ' Your input: ' + inputStr;
//   }
// }

//post data to server
// Future<String> postInput(String inputStr) async {
//
//   HttpClient httpClient = HttpClient();
//
//   final response = await http.post(
//     queryUri,
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'input': inputStr,
//     })
//   );
//
//   if (response.statusCode == 200){
//     // If the server did return a 201 CREATED response,
//     // then parse the JSON.
//     return jsonDecode(response.body);
//   } else {
//     // If the server did not return a 201 CREATED response,
//     // then throw an exception.
//     throw Exception('Failed to get respond string.');
//   }
// }
