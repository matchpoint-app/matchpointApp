import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  const Layout({@required this.body, @required this.pageTitle, Key key})
      : super(key: key);

  final Widget body;
  final String pageTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(pageTitle),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 0,
          items: [
            BottomNavigationBarItem(
              title: Text('Games'),
              icon: const Icon(Icons.sync),
            ),
            BottomNavigationBarItem(
              title: Text('Chat'),
              icon: const Icon(Icons.chat_bubble_outline),
            ),
            BottomNavigationBarItem(
              title: Text('Profile'),
              icon: const Icon(Icons.settings),
            ),
          ],
        ),
        body: body);
  }
}
