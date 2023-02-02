import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'bubble.dart';

class LoadBubble extends Bubble {
  const LoadBubble();

  @override
  LoadBubbleState createState() => LoadBubbleState();
}

class LoadBubbleState extends State<LoadBubble> {
  @override
  Widget build(BuildContext context) {
    return _buildBubble();
  }

  Widget _buildBubble() {
    return Padding(
      // asymmetric padding
      padding: const EdgeInsets.fromLTRB(16.0, 4, 300.0, 4),
      child: Align(
        // align the child within the container
        alignment: Alignment.centerLeft,
        child: DecoratedBox(
          // chat bubble decoration
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Padding(
              padding: EdgeInsets.all(32),
              child: SpinKitThreeBounce(
                color: Colors.black,
                size: 10.0,
              )),
        ),
      ),
    );
  }
}
