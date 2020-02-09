import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:matchpoint/models/profile-information.dart';

class SearchFriendItem extends StatelessWidget {
  final ProfileInformation user;
  final VoidCallback onAddTap;
  final bool userAdded;

  const SearchFriendItem({this.user, this.onAddTap, this.userAdded});

  @override
  Widget build(BuildContext ctx) {
    bool added = userAdded;
    return ListTile(
        leading: Icon(
          Icons.person,
          size: 48,
        ),
        title: Text(user.name != null ? user.name : "Unknown"),
        subtitle: Row(children: <Widget>[
          Icon(Icons.star, size: 14, color: Colors.black45),
          SizedBox(width: 5),
          Text(user.rating != null ? user.rating.toString() : "0",
              style: TextStyle(fontSize: 12))
        ]),
        trailing: StatefulBuilder(builder: (context, setState) {
          return !added
              ? FloatingActionButton(
                  child: Icon(Icons.add),
                  onPressed: () => {
                    setState(() {
                      this.onAddTap();
                      added = true;
                    }),
                  },
                  elevation: 4,
                  mini: true,
                  backgroundColor: Color.fromRGBO(234, 234, 234, 1),
                  foregroundColor: Color.fromRGBO(43, 59, 67, 1),
                )
              : IconButton(
                  icon: Icon(Icons.remove_circle),
                  onPressed: () => {
                    setState(() {
                      this.onAddTap();
                      added = false;
                    }),
                  },
                  color: Colors.red,
                );
        }));
  }
}
