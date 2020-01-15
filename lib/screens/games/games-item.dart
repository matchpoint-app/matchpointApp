import 'package:flutter/material.dart';

class GamesItem extends StatelessWidget {
  GamesItem({@required this.title, this.onPress});

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
