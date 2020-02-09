import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:matchpoint/models/profile-information.dart';
import 'package:matchpoint/screens/games/components/search-friend-item.dart';
import 'package:matchpoint/services/userDatabase.dart';
import 'package:matchpoint/globals.dart' as globals;

class SearchFriendList extends StatelessWidget {
  final Function(ProfileInformation user) onAddTap;
  final List<ProfileInformation> invitedPlayers;
  const SearchFriendList({this.onAddTap, this.invitedPlayers});

  @override
  Widget build(BuildContext context) {
    List<ProfileInformation> users = new List<ProfileInformation>();
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text("Invite friends to event"),
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context, false),
          )),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: StatefulBuilder(builder: (context, setState) {
          return Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 20.0),
              ),
              TextField(
                  decoration: InputDecoration(labelText: "Search friends"),
                  onChanged: (searchTerm) async {
                    users.clear();
                    var searchResult = await UserDatabaseService()
                        .searchFriends(
                            searchTerm, globals.userInformation.friends);
                    setState(() {
                      for (var document in searchResult) {
                        users.add(ProfileInformation.fromJson(document.data));
                      }
                    });
                  }),
              Expanded(
                  child: ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SearchFriendItem(
                          user: users[index],
                          onAddTap: () => onAddTap(users[index]),
                          userAdded: invitedPlayers
                              .any((player) => player.id == users[index].id),
                        );
                      })),
            ],
          );
        }),
      ),
    );
  }
}

class SearchListItem {}
