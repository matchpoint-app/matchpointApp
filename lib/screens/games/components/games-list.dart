import 'package:flutter/material.dart';
import 'package:matchpoint/models/game.dart';
import 'package:matchpoint/models/location.dart';
import 'package:matchpoint/screens/games/components/games-list-card.dart';

class GamesList extends StatelessWidget {
  final List<Game> list = List<Game>.generate(
      10,
      (i) => new Game(
          id: '$i',
          title: 'Game ${i + 1}',
          location: new Location(),
          time: DateTime.now(),
          players: [
            {'userId': 1},
            {'userId': 2}
          ],
          maxPlayers: 4));

  void onListItemClick(BuildContext ctx) {
    Navigator.push(
        ctx,
        new MaterialPageRoute(
            builder: (ctx) => Scaffold(
                appBar: AppBar(
                  title: Text("TO DO"),
                ),
                body: Center(child: Text("TEST"))),
            fullscreenDialog: true));
  }

  @override
  Widget build(BuildContext ctx) {
    return ListView(
        children: list
            .map((game) => GestureDetector(
                onTap: () => onListItemClick(ctx), child: GamesListCard(game)))
            .toList());
  }
}
