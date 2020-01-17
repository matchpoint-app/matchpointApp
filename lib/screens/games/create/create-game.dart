import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:matchpoint/ui/layout.dart';
import 'package:matchpoint/ui/user-list-item.dart';

class CreateGame extends StatelessWidget {
  final String pageTitle;

  const CreateGame(this.pageTitle);

  void _onAddFriendPressed() {
    // TODO: impl
  }

  void _onRemoveFriendPressed() {
    // TODO: impl
  }

  @override
  Widget build(BuildContext ctx) {
    return Layout(
        pageTitle: "Create $pageTitle",
        body: ListView(children: <Widget>[
          Card(
              margin: EdgeInsets.all(12),
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                    child: Text(pageTitle,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ),
                  ListTile(
                    leading: Icon(Icons.calendar_today),
                    title: Text("Select date"),
                  ),
                  ListTile(
                    leading: Icon(Icons.add_location),
                    title: Text("Select location"),
                  ),
                  Padding(
                      padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                      child:
                          Text("Skill level", style: TextStyle(fontSize: 16))),
                  Slider(
                      min: 0.0, max: 10.0, value: 4, onChanged: (value) => {})
                ],
              )),
          Card(
              margin: EdgeInsets.all(12),
              elevation: 4,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: TextFormField(
                      maxLines: 2,
                      decoration: InputDecoration(labelText: "Description")))),
          Card(
              margin: EdgeInsets.all(12),
              elevation: 4,
              child: Column(
                children: <Widget>[
                  ListTile(
                      title: Text("Invite friends"),
                      trailing: FloatingActionButton(
                        child: Icon(Icons.add),
                        mini: true,
                        elevation: 0,
                        onPressed: _onAddFriendPressed,
                      )),
                  Divider(),
                  UserListItem(
                    name: 'Conny',
                    rating: '3.5/5',
                  ),
                  UserListItem(
                    name: 'Berit',
                    rating: '5.0/5',
                  ),
                ],
              )),
        ]));
  }
}
