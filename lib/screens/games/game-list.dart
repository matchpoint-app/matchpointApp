import 'package:flutter/material.dart';
import 'package:matchpoint/screens/games/game-card.dart';
import 'package:matchpoint/ui/layout.dart';
import 'dart:math';

class Game {
  const Game(
      {this.title, this.time, this.location, this.usersJoined, this.usersMax});
  final String title;
  final String time;
  final String location;
  final int usersJoined;
  final int usersMax;
}

class GameList extends StatelessWidget {
  GameList(this.pageTitle);

  final String pageTitle;

  final List<Game> list = new List<Game>.generate(
      10,
      (i) => new Game(
          title: 'Game ${i + 1}',
          location: 'Enskede Rackethall',
          time: 'Sun, 10:00-11:00',
          usersJoined: Random().nextInt(5),
          usersMax: 4));

  void onListItemClick(BuildContext ctx) {
    Navigator.push(
        ctx, new MaterialPageRoute(builder: (ctx) => new GameList("asd")));
  }

  @override
  Widget build(BuildContext ctx) {
    return Layout(
        pageTitle: pageTitle,
        includeBottomNav: false,
        body: ListView(
            children: list
                .map((game) => GestureDetector(
                    onTap: () => onListItemClick(ctx),
                    child: GameCard(
                      title: game.title,
                      time: game.time,
                      location: game.location,
                      usersJoined: game.usersJoined,
                      usersMax: game.usersMax,
                    )))
                .toList()));
  }
}
