import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_map_location_picker/google_map_location_picker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:matchpoint/models/game-information.dart';
import 'package:matchpoint/models/profile-information.dart';
import 'package:matchpoint/ui/loading-indicator.dart';
import 'package:matchpoint/ui/user-list-item.dart';

class Game extends StatelessWidget {
  final GameInformation game;
  const Game({this.game});

  void _onRemoveFriendPressed(String uid) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(game.title), centerTitle: true),
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

  Widget get type {
    return ListTile(
      leading: Icon(Icons.gamepad, color: Color.fromRGBO(221, 110, 66, 1)),
      title: Text("${game.type}", style: TextStyle(fontSize: 16)),
    );
  }

  Widget get maxPlayers {
    return ListTile(
      leading: Icon(Icons.people, color: Color.fromRGBO(221, 110, 66, 1)),
      title: Text("${game.usersMax}", style: TextStyle(fontSize: 16)),
    );
  }

  Widget get private {
    return ListTile(
      leading: Icon(game.private ? Icons.lock : Icons.lock_open,
          color: Color.fromRGBO(221, 110, 66, 1)),
      title: Text("${game.private ? "Yes" : "No"}",
          style: TextStyle(fontSize: 16)),
    );
  }

  Widget get date {
    return ListTile(
      leading:
          Icon(Icons.calendar_today, color: Color.fromRGBO(221, 110, 66, 1)),
      title: Text(DateFormat("MMM dd hh:mm").format(game.time.toDate())),
    );
  }

  Widget location(BuildContext context) {
    return Container(
      width: 400,
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
    Stream<QuerySnapshot> stream = Firestore.instance
        .collection('users')
        .where("id", whereIn: game.players)
        .snapshots();

    return StatefulBuilder(builder: (context, setState) {
      return StreamBuilder<QuerySnapshot>(
          stream: stream,
          builder: (ctx, snapshot) {
            if (!snapshot.hasData) return Center(child: LoadingIndicator());
            return Card(
              color: Color.fromRGBO(234, 234, 234, 1),
              margin: EdgeInsets.all(10),
              elevation: 4,
              child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Players joined",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      Divider(),
                      for (var user in snapshot.data.documents)
                        UserListItem(
                            user: ProfileInformation.fromJson(user),
                            onRemoveTap: () => setState(() {
                                  Firestore()
                                      .collection("games")
                                      .document(game.id)
                                      .updateData({
                                    "players": FieldValue.arrayRemove(
                                        [user.documentID])
                                  });
                                })),
                    ],
                  )),
            );
          });
    });
  }
}
