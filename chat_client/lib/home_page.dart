import 'dart:async';
import 'dart:io';

import 'package:chat_client/services/chat_service.dart';
import 'package:flutter/material.dart';

import 'bubble_message.dart';
import 'generated/grpc/chat.pb.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _messageController = TextEditingController();
  final _chatService = ChatService();
  // ignore: close_sinks
  final _outgoingMessages = StreamController<ChatMessage>();
  Stream<ChatMessage>? _incomingMessages;
  final _bubbles = <BubbleMessageModel>[];
  final _scrollController = ScrollController();
  late StreamSubscription _incomingMessagesSubscription;

  @override
  void initState() {
    print('initializing state');
    super.initState();
    _incomingMessages = _chatService.createChat(_outgoingMessages.stream);
    _incomingMessagesSubscription = _incomingMessages!.listen(
      (ChatMessage cm) {
        print('Incoming message: ${cm.message}');
        _addMessage(
          BubbleMessageModel(
            cm.message,
            BubbleMessageType.receiver,
          ),
        );
      },
      onDone: () => print('Incoming done'),
      onError: (e) => print('Error $e'),
    );
    //Add the first bubble:
    _addMessage(
      BubbleMessageModel('TODAY', BubbleMessageType.date),
    );
  }

  @override
  void dispose() {
    _incomingMessagesSubscription.cancel();
    _outgoingMessages.close();
    _chatService.shutdown();
    super.dispose();
    exit(0);
  }

  void _sendMessage() {
    _addMessage(
      BubbleMessageModel(
        _messageController.text,
        BubbleMessageType.sender,
      ),
    );
    final message = ChatMessage()..message = _messageController.text;
    _outgoingMessages.add(message);
    _messageController.text = '';
  }

  void _addMessage(BubbleMessageModel bm) {
    setState(() {
      _bubbles.add(bm);
    });
    scheduleMicrotask(() {
      if (_scrollController.position.maxScrollExtent > 0)
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 30,
          duration: Duration(milliseconds: 500),
          curve: Curves.fastLinearToSlowEaseIn, //fastOutSlowIn
        );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            tooltip: 'Open shopping cart',
            onPressed: () => dispose(),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView(
                  controller: _scrollController,
                  children: [for (var bm in _bubbles) BubbleMessage(bubbleMessageModel: bm)],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      autofocus: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      onSubmitted: (value) => _sendMessage(),
                    ),
                  ),
                  IconButton(
                    onPressed: () => _sendMessage(),
                    icon: Icon(
                      Icons.send,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
