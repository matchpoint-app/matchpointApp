import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:matchpoint/screens/games/components/create-game.dart';
import 'package:matchpoint/screens/games/components/games-list.dart';

class GamesContainer extends StatefulWidget {
  const GamesContainer({Key key}) : super(key: key);

  @override
  _GamesContainerState createState() => _GamesContainerState();
}

class _GamesContainerState extends State<GamesContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Games")),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              print('press');
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (ctx) => CreateGame(
                            pageTitle: "test",
                          ),
                      fullscreenDialog: true));
            }),
        body: GamesList());
  }
}
