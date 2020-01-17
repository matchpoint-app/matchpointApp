import 'package:flutter/material.dart';
import 'package:matchpoint/models/game.dart';
import 'package:matchpoint/screens/games/create/create-game.dart';
import 'package:matchpoint/screens/games/game-card.dart';
import 'package:matchpoint/ui/layout.dart';
import 'dart:math';

class GameList extends StatelessWidget {
  GameList(this.pageTitle);

  final String pageTitle;

  final List<Game> list = new List<Game>.generate(
      10,
      (i) => new Game(
          id: '$i',
          title: 'Game ${i + 1}',
          location: 'Enskede Rackethall',
          time: 'Sun, 10:00-11:00',
          usersJoined: Random().nextInt(5),
          usersMax: 4));

  void onListItemClick(BuildContext ctx) {
    Navigator.push(
        ctx,
        new MaterialPageRoute(
            builder: (ctx) => new GameList("asd"), fullscreenDialog: true));
  }

  @override
  Widget build(BuildContext ctx) {
    return Layout(
        pageTitle: pageTitle,
        includeBottomNav: false,
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              print('press');
              Navigator.push(
                  ctx,
                  MaterialPageRoute(
                      builder: (ctx) => CreateGame(pageTitle),
                      fullscreenDialog: true));
            }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: ListView(
            children: list
                .map((game) => GestureDetector(
                    onTap: () => onListItemClick(ctx), child: GameCard(game)))
                .toList()));
  }
}
