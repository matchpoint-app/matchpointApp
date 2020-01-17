import 'package:flutter/material.dart';

class Layout extends StatelessWidget {
  const Layout(
      {@required this.body,
      @required this.pageTitle,
      this.includeBottomNav = true,
      this.floatingActionButton,
      this.floatingActionButtonLocation,
      this.actions,
      Key key})
      : super(key: key);

  final Widget body;
  final Widget floatingActionButton;
  final FloatingActionButtonLocation floatingActionButtonLocation;
  final String pageTitle;
  final bool includeBottomNav;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(pageTitle),
          actions: actions,
        ),
        bottomNavigationBar: includeBottomNav ? buildBottomNavigation() : null,
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
        body: body);
  }

  Widget buildBottomNavigation() => BottomNavigationBar(
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
      );
}
