import 'package:flutter/material.dart';
import 'package:matchpoint/screens/social/components/message.dart';

class ChatMessage {
  const ChatMessage({this.author, this.message, this.isReceived = false});
  final String author;
  final String message;
  final bool isReceived;
}

class Chat extends StatelessWidget {
  List<ChatMessage> items = [
    ChatMessage(
        author: 'Johnny', message: 'Hello to our chat', isReceived: true),
    ChatMessage(author: 'Birgit', message: '<3 play boll', isReceived: false),
    ChatMessage(author: 'Larsa', message: '😊', isReceived: true),
    ChatMessage(
        author: 'Sven', message: 'äger er alla haha\nny rad', isReceived: true),
  ];

  void _onSettingsPress() {
    print("pressed settings");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Chat"),
          actions: <Widget>[
            IconButton(
                onPressed: _onSettingsPress,
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ))
          ],
        ),
        body: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 12),
          ),
          Flexible(child: _buildChat)
        ]));
  }

  Widget get _buildChat {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Message(
          chat: items[index],
        );
      },
    );
  }
}
