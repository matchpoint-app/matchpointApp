import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:matchpoint/models/game-information.dart';
import 'package:matchpoint/screens/games/components/game.dart';
import 'package:matchpoint/services/eventDatabase.dart';
import 'package:matchpoint/ui/loading-indicator.dart';
import 'package:provider/provider.dart';

class GameContainer extends StatefulWidget {
  final GameInformation game;
  const GameContainer({Key key, this.game}) : super(key: key);

  @override
  _GameContainerState createState() => new _GameContainerState();
}

class _GameContainerState extends State<GameContainer> {
  final eventDatabase = EventDatabaseService();
  FirebaseUser user;

  @override
  Widget build(BuildContext context) {
    user = Provider.of<FirebaseUser>(context);
    return Scaffold(
        body: StreamProvider<GameInformation>.value(
            // All children will have access to weapons data
            value: eventDatabase.streamGameInformation(widget.game),
            child: buildConsumer()));
  }

  Widget buildConsumer() {
    return Consumer<GameInformation>(builder: (_, game, __) {
      if (game == null) {
        return Center(child: LoadingIndicator());
      }

      return Game(
        game: game,
        userId: user.uid,
      );
    });
  }
}
