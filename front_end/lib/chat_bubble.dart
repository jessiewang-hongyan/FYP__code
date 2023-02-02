import 'package:flutter/material.dart';
import 'bubble.dart';

class ChatBubble extends Bubble {
  final String text;
  final bool isCurrentUser;
  const ChatBubble(this.text, this.isCurrentUser);

  @override
  ChatBubbleState createState() => ChatBubbleState();
}

class ChatBubbleState extends State<ChatBubble> {
  static final _saved = <ChatBubble>{};
  static const _biggerFont = TextStyle(fontSize: 18.0);

  bool alreadySaved = false;

  @override
  Widget build(BuildContext context) {
    return _buildBubble(widget.text, widget.isCurrentUser);
  }

  static Iterable<ListTile> getSaved() {
    final tiles = _saved.map(
          (ChatBubble b) {
        return ListTile(
          title: Text(
            b.text,
            style: _biggerFont,
          ),
        );
      },
    );
    return tiles;
  }

  void toggleSavedState() {
    alreadySaved = !alreadySaved;
  }

  Widget _buildBubble(text, isCurrentUser) {
    return Padding(
      // asymmetric padding
      padding: EdgeInsets.fromLTRB(
        widget.isCurrentUser ? 64.0 : 16.0,
        4,
        widget.isCurrentUser ? 16.0 : 64.0,
        4,
      ),
      child: Align(
        // align the child within the container
        alignment: isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: DecoratedBox(
          // chat bubble decoration
          decoration: BoxDecoration(
            color: isCurrentUser ? Colors.blue : Colors.grey[300],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: ListTile(
              title: Text(
                text,
                style: widget.isCurrentUser
                    ? const TextStyle(color: Colors.white)
                    : const TextStyle(color: Colors.black),
              ),
              trailing: widget.isCurrentUser
                  ? null
                  : Icon(
                alreadySaved ? Icons.favorite : Icons.favorite_border,
                color: alreadySaved ? Colors.red : null,
              ),
              onTap: widget.isCurrentUser
                  ? null
                  : () {
                //call setState() will call build() the State object
                setState(() {
                  if (alreadySaved) {
                    _saved.remove(widget);
                  } else {
                    _saved.add(widget);
                  }
                  toggleSavedState();
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
