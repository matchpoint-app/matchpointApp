import 'package:flutter/material.dart';

class ChatInput extends StatelessWidget {
  const ChatInput({@required this.controller, @required this.onSendMessage});

  final TextEditingController controller;
  final void Function(String) onSendMessage;

  @override
  Widget build(context) {
    return Container(
      child: Row(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(left: 24)),
          /*Container(
            margin: EdgeInsets.symmetric(horizontal: 1.0),
            child: IconButton(
              icon: Icon(Icons.image),
              onPressed: () => {},
            ),
          ),*/
          Flexible(
            child: Container(
              child: TextField(
                style: TextStyle(color: Colors.black, fontSize: 15.0),
                controller: controller,
                onSubmitted: this.onSendMessage,
                decoration: InputDecoration.collapsed(
                  hintText: 'Write something...',
                  hintStyle: TextStyle(color: Colors.grey),
                ),
                // focusNode: focusNode,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 8.0),
            child: IconButton(
              icon: Icon(Icons.send),
              onPressed: () => onSendMessage(controller.text),
              color: Color.fromRGBO(221, 110, 66, 1),
            ),
          ),
        ],
      ),
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(
          border: Border(top: BorderSide(color: Colors.black, width: 0.5)),
          color: Colors.white),
    );
  }
}
