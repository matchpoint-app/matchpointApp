import 'package:flutter/material.dart';
import 'package:matchpoint/models/game.dart';

class GameCard extends StatelessWidget {
  const GameCard(this.game);

  final Game game;

  @override
  Widget build(BuildContext ctx) {
    return Card(
      margin: EdgeInsets.all(12),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
        child: Row(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(game.title,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Row(children: [
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 6, 0),
                          child: Icon(Icons.calendar_today)),
                      Text(
                        game.time.toString(),
                      )
                    ])),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                    child: Row(children: [
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 6, 0),
                          child: Icon(Icons.add_location)),
                      Text(
                        game.location.toString(),
                      )
                    ])),
              ],
            ),
            Spacer(),
            FloatingActionButton(
              heroTag: game.title,
              onPressed: () => {},
              child: Text("${game.players}/${game.usersMax}"),
            ),
          ],
        ),
      ),
    );
  }
}
