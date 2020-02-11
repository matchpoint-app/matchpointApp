import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:matchpoint/models/profile-information.dart';

class UserListItem extends StatelessWidget {
  final VoidCallback onRemoveTap;
  final ProfileInformation user;

  const UserListItem({this.user, this.onRemoveTap});

  @override
  Widget build(BuildContext ctx) {
    return ListTile(
      leading: user.photoUrl != null
          ? CircleAvatar(
              radius: 30, backgroundImage: NetworkImage(user.photoUrl))
          : Text("no image"),
      title: Text(user.name),
      subtitle: Row(children: <Widget>[
        Icon(Icons.star, size: 14, color: Colors.black45),
        Text(user.rating ?? "0", style: TextStyle(fontSize: 12))
      ]),
      trailing: onRemoveTap != null
          ? IconButton(
              icon: Icon(Icons.remove_circle),
              color: Colors.red,
              onPressed: onRemoveTap,
            )
          : null,
    );
  }
}
