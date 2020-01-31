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
          title: Center(
              child: Text(FlutterI18n.translate(context, 'games.games'))),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: floatingActionButton,
        body: GamesList());
  }

  Widget get floatingActionButton {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (ctx) => CreateGame(
                pageTitle: "test",
              ),
            )));
  }
}
