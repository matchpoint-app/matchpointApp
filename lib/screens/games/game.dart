import 'package:flutter/material.dart';
import 'package:matchpoint/ui/layout.dart';

class Game extends StatelessWidget {
  const Game(this.pageTitle);

  final String pageTitle;

  @override
  Widget build(BuildContext ctx) {
    return Layout(
        pageTitle: pageTitle,
        includeBottomNav: false,
        body: Center(
          child: Text("woo"),
        ));
  }
}
