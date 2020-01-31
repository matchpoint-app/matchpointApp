import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SocialCardItem extends StatelessWidget {
  const SocialCardItem({this.tag, this.title, this.subtitle, this.onTap});

  final String tag;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: new Hero(
        tag: tag,
        child: new CircleAvatar(),
      ),
      title: new Text(title),
      subtitle: new Text(subtitle),
    );
  }
}
