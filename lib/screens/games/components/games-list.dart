import 'package:flutter/material.dart';
import 'package:matchpoint/models/game-information.dart';
import 'package:matchpoint/screens/games/components/games-list-card.dart';

class GamesList extends StatelessWidget {
  final List<GameInformation> games;
  const GamesList({this.games});

  void onListItemClick(BuildContext ctx) {
    Navigator.push(
        ctx,
        new MaterialPageRoute(
            builder: (ctx) => Scaffold(
                appBar: AppBar(
                  backgroundColor: Color.fromRGBO(43, 59, 67, 1),
                  title: Text("TO DO"),
                ),
                backgroundColor: Color.fromRGBO(234, 234, 234, 1),
                body: Center(child: Text("TEST"))),
            fullscreenDialog: true));
  }

  @override
  Widget build(BuildContext ctx) {
    return Container(
      height: MediaQuery.of(ctx).size.height - 200,
      child: games.length > 0
          ? ListView.builder(
              itemCount: games.length,
              itemBuilder: (ctx, index) {
                return GamesListCard(games[index]);
              },
            )
          : Center(child: Text("No games here at the moment...")),
    );
  }
}
