import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:matchpoint/models/game.dart';

class GamesListCard extends StatelessWidget {
  const GamesListCard(this.game);

  final Game game;

  @override
  Widget build(BuildContext ctx) {
    return Card(
      color: Color.fromRGBO(234, 234, 234, 1),
      margin: EdgeInsets.all(10),
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
                        DateFormat("dd-MM hh:mm").format(game.time.toDate()),
                        style: TextStyle(fontSize: 14),
                      )
                    ])),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                    child: Row(children: [
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 6, 0),
                          child: Icon(Icons.add_location)),
                      Text(
                        game.location.name,
                      )
                    ])),
              ],
            ),
            Spacer(),
            Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                      width: 2,
                      color: Colors.deepOrange,
                      style: BorderStyle.solid)),
              child: Center(
                  child: Text("${game.players.length}/${game.usersMax}")),
            ),
          ],
        ),
      ),
    );
  }
}
