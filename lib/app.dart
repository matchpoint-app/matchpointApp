import 'package:flutter/material.dart';
import 'package:matchpoint/screens/games/containers/games.dart';
import 'package:matchpoint/screens/home/containers/home.dart';

class MatchpointApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Matchpoint',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
          // counter didn't reset back to zero; the application is not restarted.
          primarySwatch: Colors.blue,
          buttonColor: Colors.pink,
          primaryIconTheme: IconThemeData(color: Colors.black)),
      home: AppContainer(title: 'MatchpointApp'),
    );
  }
}

class AppContainer extends StatefulWidget {
  AppContainer({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AppContainerState createState() => _AppContainerState();
}

PageController pageController;

class _AppContainerState extends State<AppContainer> {
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Container(
            color: Colors.white,
            child: HomeContainer(),
          ),
          Container(color: Colors.white, child: GamesContainer()),
        ],
        controller: pageController,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home,
                  color: (_page == 0) ? Colors.black : Colors.grey),
              title: Container(height: 0.0),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.games,
                  color: (_page == 1) ? Colors.black : Colors.grey),
              title: Container(height: 0.0),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble,
                  color: (_page == 2) ? Colors.black : Colors.grey),
              title: Container(height: 0.0),
              backgroundColor: Colors.white),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline,
                  color: (_page == 3) ? Colors.black : Colors.grey),
              title: Container(height: 0.0),
              backgroundColor: Colors.white),
        ],
        onTap: navigationTapped,
        currentIndex: _page,
      ),
    );
  }

  void navigationTapped(int page) {
    if (page >= 2) return;
    pageController.jumpToPage(page);
  }

  void onPageChanged(int page) {
    setState(() {
      this._page = page;
    });
  }

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
}