import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:matchpoint/models/game-information.dart';
import 'package:matchpoint/models/profile-information.dart';
import 'package:matchpoint/services/eventDatabase.dart';
import 'package:matchpoint/ui/user-list-item.dart';

class Game extends StatelessWidget {
  final String userId;
  final GameInformation game;
  final List<DocumentSnapshot> players;
  const Game({this.userId, this.game, this.players});

  void _onRemoveFriendPressed(ProfileInformation player) {
    Firestore().collection("games").document(game.id).updateData({
      "players": FieldValue.arrayRemove([player.id])
    });
  }

  void _joinGame() async {
    if (game.invitedPlayers.any((player) => player == userId))
      await EventDatabaseService().joinGame(userId, game.id);
    else
      EventDatabaseService().requestToJoinGame(userId, game.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(game.title), centerTitle: true),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: game.players.any((player) => player == userId)
            ? null
            : floatingActionButton,
        body: ListView(children: <Widget>[
          cardGameDescription,
          Card(
              color: Color.fromRGBO(234, 234, 234, 1),
              margin: EdgeInsets.all(10),
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  type,
                  maxPlayers,
                  private,
                  date,
                  location(context),
                  skillText,
                  slider
                ],
              )),
          friends,
        ]));
  }

  Widget get floatingActionButton {
    return FloatingActionButton(
        child: Text("Join"), onPressed: () => _joinGame());
  }

  Widget get type {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Text("${game.type}",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    );
  }

  Widget get maxPlayers {
    return Container(
      height: 40,
      child: ListTile(
        leading: Icon(Icons.people, color: Color.fromRGBO(221, 110, 66, 1)),
        title: Text("${game.usersMax}", style: TextStyle(fontSize: 16)),
      ),
    );
  }

  Widget get private {
    return Container(
      height: 40,
      child: ListTile(
        leading: Icon(game.private ? Icons.lock : Icons.lock_open,
            color: Color.fromRGBO(221, 110, 66, 1)),
        title: Text("${game.private ? "Yes" : "No"}",
            style: TextStyle(fontSize: 16)),
      ),
    );
  }

  Widget get date {
    return Container(
      height: 40,
      child: ListTile(
          leading: Icon(Icons.calendar_today,
              color: Color.fromRGBO(221, 110, 66, 1)),
          title: Text(
            DateFormat("MMM dd hh:mm").format(game.time.toDate()),
          )),
    );
  }

  Widget location(BuildContext context) {
    return Container(
      width: 400,
      height: 40,
      child: ListTile(
        leading:
            Icon(Icons.add_location, color: Color.fromRGBO(221, 110, 66, 1)),
        title: (game.location.name != null && game.location.name != null)
            ? Text(game.location.name, overflow: TextOverflow.ellipsis)
            : Text("Select location"),
        onTap: () async {
          var latLng = LatLng(game.location.latitude, game.location.longitude);
          await showLocationPicker(
              context, "AIzaSyDwXHA1MmHgMGTZZ2IHM_sLHqQbz9LM0uU",
              initialCenter: latLng,
              automaticallyAnimateToCurrentLocation: false,
              myLocationButtonEnabled: true,
              layersButtonEnabled: true);
        },
      ),
    );
  }

  Widget get skillText {
    return Padding(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
        child: RichText(
            text: TextSpan(
          style: TextStyle(fontSize: 16, color: Colors.black),
          children: [
            TextSpan(text: "Skill level: "),
            TextSpan(
                text: "${game.skillLevel.toInt()}",
                style: TextStyle(fontWeight: FontWeight.bold))
          ],
        )));
  }

  Widget get slider {
    return Slider(
        min: 0.0,
        max: 10.0,
        value: game.skillLevel,
        onChanged: (value) => {null});
  }

  Widget get cardGameDescription {
    return Card(
      color: Color.fromRGBO(234, 234, 234, 1),
      margin: EdgeInsets.all(10),
      elevation: 4,
      child: Container(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(game.title,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text(game.description, style: TextStyle(fontSize: 16))
              ])),
    );
  }

  Widget get friends {
    return Card(
        color: Color.fromRGBO(234, 234, 234, 1),
        margin: EdgeInsets.all(10),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance
                  .collection("users")
                  .where("id",
                      whereIn: game.players.length > 0 ? game.players : [""])
                  .snapshots(),
              builder: (ctx, snapshot) {
                if (snapshot == null || snapshot.data == null)
                  return Text("Error");
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Players joined",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Divider(),
                    if (snapshot.data != null)
                      for (var player in snapshot.data.documents)
                        UserListItem(user: ProfileInformation.fromJson(player))
                  ],
                );
              }),
        ));
  }
}
