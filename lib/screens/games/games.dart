import 'package:flutter/material.dart';
import 'package:matchpoint/screens/games/list-item.dart';

class Games extends StatelessWidget {
  final List items = ["Tennis", "Football", "Badminton", "Hockey"];

  void onPress(String title) {
    print("Pressed $title");
  }

  @override
  Widget build(BuildContext ctx) {
    return Container(
      padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
      child: new ListView(
        children: items
            .map((title) => ListItem(
                  title: title,
                  onPress: this.onPress,
                ))
            .toList(),
      ),
    );
  }
}
