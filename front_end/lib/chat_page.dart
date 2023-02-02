import 'package:flutter/material.dart';
import 'dart:async';

import 'bubble.dart';
import 'chat_bubble.dart';
import 'loading_bubble.dart';
import 'http_connection.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Bubble> chats = [];
  final textController = TextEditingController();
  bool _validate = false;
  late LoadBubble loadPointer;
  bool _sayHello = false;

  @override
  Widget build(BuildContext context) {
    if(!_sayHello) {
      _connectSayHello();
      _sayHello = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chatbot Interface'),
        actions: [
          IconButton(icon: const Icon(Icons.list), onPressed: _pushSaved),
        ],
      ),
      body: _buildBubbleList(),
      bottomSheet: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextField(
                    controller: textController,
                    onSubmitted: (value) {
                      submitInput();
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      hintText: 'Type something',
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.send),
                        onPressed: submitInput,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Future<String> generateRespond(inputStr) async {
    // print('Sleep start');
    // return request(inputStr);
    return postInput(inputStr);
  }

  Future<bool?> emptyInputDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Notice"),
          content: const Text("Empty Message cannot be sent!"),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () => Navigator.of(context).pop(), // 关闭对话框
            )
          ],
        );
      },
    );
  }

  Widget _buildRow(text, isCurrentUser) {
    return ChatBubble(text, isCurrentUser);
  }

  Widget _buildLoadingRow() {
    loadPointer = LoadBubble();
    return loadPointer;
  }

  Widget _buildBubbleList() {
    return ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          return chats[index];
        });
  }

  //connect to server and print a hello message
  Future<void> _connectSayHello() async {
    setState(() {
      //add loading cell
      _addToList(_buildLoadingRow());
    });

    String respond = await _queryGreeting();

    setState(() {
      //remove loading cell
      _removeLoadingRow();

      //add respond bubble
      _addToList(_buildRow(respond, false));

    });
  }

  Future<String> _queryGreeting() async {
    // print('Sleep start');
    return requestGreeting();
  }

  void submitInput() async {
    //check empty input
    textController.text.isEmpty ? _validate = false : _validate = true;

    if (_validate) {
      var inputString = textController.text;

      setState(() {
        //add user chat bubble
        _addToList(_buildRow(inputString, true));

        //add loading cell
        _addToList(_buildLoadingRow());
      });

      //clear input
      textController.clear();

      //close keyboard
      FocusScope.of(context).unfocus();

      String respond = await generateRespond(inputString);

      setState(() {
        //remove loading cell
        _removeLoadingRow();

        //add respond bubble
        _addToList(_buildRow(respond, false));

      });

    } else {
      emptyInputDialog();
    }
  }

  void _removeLoadingRow() {
    chats.removeWhere((item) => item == loadPointer);
  }

  void _addToList(item) {
    chats.add(item);
  }

  void _pushSaved() {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (BuildContext context) {
        final tiles = ChatBubbleState.getSaved();

        final divided =
            ListTile.divideTiles(context: context, tiles: tiles).toList();

        return Scaffold(
          appBar: AppBar(
            title: const Text('Saved Records'),
          ),
          body: ListView(children: divided),
        );
      },
    ));
  }
}
