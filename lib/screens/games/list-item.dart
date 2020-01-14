import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  ListItem({@required this.title, this.onPress});

  final String title;
  final Function(String) onPress;

  @override
  Widget build(BuildContext ctx) {
    return Card(
      child: ListTile(
        title: Text(title),
        onTap: () => onPress(this.title),
      ),
    );
  }
}
