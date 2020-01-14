import 'package:flutter/material.dart';
import 'package:matchpoint/screens/games/game.dart';
import 'package:matchpoint/screens/games/list-item.dart';

class Games extends StatelessWidget {
  final List items = ["Tennis", "Football", "Badminton", "Hockey"];

  void onPress(String title, BuildContext ctx) {
    print("Pressed $title");
    Navigator.push(
        ctx, new MaterialPageRoute(builder: (ctx) => new Game(title)));
  }

  List<Widget> getItems(BuildContext ctx) {
    return items
        .map((title) => ListItem(
              title: title,
              onPress: (title) => this.onPress(title, ctx),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext ctx) {
    return Container(
      padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
      child: new ListView(children: getItems(ctx)),
    );
  }
}
