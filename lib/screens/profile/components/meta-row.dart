import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MetaRow extends StatelessWidget {
  const MetaRow({this.icon, this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 20,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(12, 0, 0, 0),
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ));
  }
}
