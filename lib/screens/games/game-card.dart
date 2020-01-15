import 'package:flutter/material.dart';

class GameCard extends StatelessWidget {
  const GameCard(
      {this.title, this.location, this.time, this.usersJoined, this.usersMax});

  final String title;
  final String location;
  final String time;
  final int usersJoined;
  final int usersMax;

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
                Text(title,
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Row(children: [
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 6, 0),
                          child: Icon(Icons.calendar_today)),
                      Text(
                        time,
                      )
                    ])),
                Padding(
                    padding: EdgeInsets.fromLTRB(0, 4, 0, 0),
                    child: Row(children: [
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 6, 0),
                          child: Icon(Icons.add_location)),
                      Text(
                        location,
                      )
                    ])),
              ],
            ),
            Spacer(),
            FloatingActionButton(
              heroTag: title,
              onPressed: () => {},
              child: Text("$usersJoined/$usersMax"),
            ),
          ],
        ),
      ),
    );
  }
}
