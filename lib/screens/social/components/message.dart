import 'package:flutter/material.dart';
import 'package:matchpoint/screens/social/containers/chat.dart';

class Message extends StatelessWidget {
  const Message({Key key, @required this.chat}) : super(key: key);

  final ChatMessage chat;

  @override
  Widget build(BuildContext context) {
    print(chat.toString());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
          child: chat.isReceived
              ? _buildReceivedMessage(context)
              : _buildSentMessage(context),
        ),
      ],
    );
  }

  Widget _buildSentMessage(BuildContext context) {
    Color sendColor = Color(0xff0084FF);
    return Container(
      alignment: Alignment.centerRight,
      child: Container(
        constraints:
            BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 3 / 4),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: sendColor,
          borderRadius: BorderRadius.circular(25.0),
        ),
        child: Text(
          chat.message,
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildReceivedMessage(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
            padding: EdgeInsets.fromLTRB(40, 0, 0, 6),
            alignment: Alignment.centerLeft,
            child: Text(
              chat.author,
            )),
        Container(
          alignment: Alignment.centerLeft,
          child: Row(
            children: <Widget>[
              chat.isReceived
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8.0),
                      child: CircleAvatar(
                        // backgroundImage: NetworkImage(),
                        radius: 12.0,
                      ),
                    )
                  : Container(
                      width: 32.0,
                      height: 24.0,
                    ),
              Container(
                constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 3 / 4),
                padding: EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Text(
                  chat.message,
                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
