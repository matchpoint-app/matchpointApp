import 'package:flutter/material.dart';

class ActionFlatButton extends StatelessWidget {
  const ActionFlatButton({@required this.onPressed, @required this.text});

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      textColor: Colors.white,
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
