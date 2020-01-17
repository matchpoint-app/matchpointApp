import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class UserListItem extends StatelessWidget {
  final VoidCallback onRemoveTap;
  final String name;
  final String rating;

  const UserListItem({this.name, this.rating, this.onRemoveTap});

  @override
  Widget build(BuildContext ctx) {
    return ListTile(
      leading: Icon(
        Icons.person,
        size: 48,
      ),
      title: Text(name),
      subtitle: Row(children: <Widget>[
        Icon(Icons.star, size: 14, color: Colors.black45),
        Text(rating, style: TextStyle(fontSize: 12))
      ]),
      trailing: onRemoveTap == null
          ? IconButton(
              icon: Icon(Icons.remove_circle),
              color: Colors.redAccent,
              onPressed: onRemoveTap,
            )
          : null,
    );
  }
}
