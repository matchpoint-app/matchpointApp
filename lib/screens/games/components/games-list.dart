import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:matchpoint/models/game.dart';
import 'package:matchpoint/models/location.dart';
import 'package:matchpoint/screens/games/components/games-list-card.dart';

class GamesList extends StatelessWidget {

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
    return StreamBuilder(
      stream: Firestore.instance.collection('games').snapshots(),
      builder: (ctx, snapshot) {
        if(!snapshot.hasData) return const Text('Loading...');
        return ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (ctx, index) {
            return GamesListCard(Game.fromJson(snapshot.data.documents[index].data));
          },
        );
      }
    );
  }
}