import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:matchpoint/models/game-information.dart';
import 'package:matchpoint/screens/games/components/games-list-card.dart';
import 'package:matchpoint/ui/loading-indicator.dart';

class GamesList extends StatelessWidget {
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
    return StreamBuilder(
        stream: Firestore.instance.collection('games').snapshots(),
        builder: (ctx, snapshot) {
          if (!snapshot.hasData) return Center(child: LoadingIndicator());
          return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (ctx, index) {
              return GamesListCard(GameInformation.fromJson(
                  snapshot.data.documents[index].data));
            },
          );
        });
  }
}
