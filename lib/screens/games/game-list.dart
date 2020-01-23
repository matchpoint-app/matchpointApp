import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:matchpoint/models/game.dart';
import 'package:matchpoint/models/location.dart';
import 'package:matchpoint/screens/games/create/create-game.dart';
import 'package:matchpoint/screens/games/game-card.dart';
import 'package:matchpoint/services/eventDatabase.dart';
import 'package:matchpoint/ui/layout.dart';

class GameList extends StatelessWidget {
  GameList(this.pageTitle);

  final String pageTitle;

  List<Map<String, dynamic>> players = [];
  final test = EventDatabaseService().getEvents();
  final List<Game> list = new List<Game>.generate(
      10,
      (i) => new Game(
          id: '$i',
          title: 'Game ${i + 1}',
          location: new Location(),
          time: DateTime.now(),
          players: [{'userId': 1}, {'userId': 2}],
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
                      builder: (ctx) => CreateGame(
                            pageTitle: this.pageTitle,
                          ),
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
