import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';

class BubbleMessageModel {
  final String message;
  final BubbleMessageType type;

  BubbleMessageModel(this.message, this.type);
}

enum BubbleMessageType {
  date,
  sender,
  receiver,
}

class BubbleMessage extends StatelessWidget {
  final BubbleMessageModel bubbleMessageModel;

  const BubbleMessage({Key? key, required this.bubbleMessageModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Bubble(
          alignment: alignment,
          color: color,
          nipWidth: 8,
          nipHeight: 10,
          nip: bubbleNip,
          child: Text(
            bubbleMessageModel.message,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 11.0),
          ),
        ),
        SizedBox(
          height: 5,
        )
      ],
    );
  }

  BubbleNip get bubbleNip {
    switch (bubbleMessageModel.type) {
      case BubbleMessageType.date:
        return BubbleNip.no;
      case BubbleMessageType.receiver:
        return BubbleNip.leftTop;
      case BubbleMessageType.sender:
        return BubbleNip.rightTop;
      default:
        return BubbleNip.no;
    }
  }

  AlignmentGeometry get alignment {
    switch (bubbleMessageModel.type) {
      case BubbleMessageType.date:
        return Alignment.topCenter;
      case BubbleMessageType.receiver:
        return Alignment.topLeft;
      case BubbleMessageType.sender:
        return Alignment.topRight;
      default:
        return Alignment.topCenter;
    }
  }

  Color get color {
    switch (bubbleMessageModel.type) {
      case BubbleMessageType.date:
        return Colors.green.shade200;
      case BubbleMessageType.receiver:
        return Colors.red.shade200;
      case BubbleMessageType.sender:
        return Colors.blue.shade200;
      default:
        return Colors.teal.shade200;
    }
  }
}
