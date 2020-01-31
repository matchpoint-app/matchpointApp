import 'package:flutter/material.dart';
import 'package:matchpoint/screens/games/containers/games.dart';
import 'package:matchpoint/screens/home/containers/home.dart';
import 'package:matchpoint/screens/profile/profile.dart';

class MatchpointApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Matchpoint',
      theme: ThemeData(
          primaryColor: Color.fromRGBO(43, 59, 67, 1),
          scaffoldBackgroundColor: Color.fromRGBO(234, 234, 234, 1),
          primaryTextTheme: TextTheme(
            title: TextStyle(color: Color.fromRGBO(234, 234, 234, 1))
          ),
          textTheme: TextTheme(
            body1: TextStyle(color: Color.fromRGBO(43, 59, 67, 1)),
            body2: TextStyle(color: Color.fromRGBO(43, 59, 67, 1))
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: Color.fromRGBO(221, 110, 66, 1),
            foregroundColor: Color.fromRGBO(234, 234, 234, 1)
          ),
          iconTheme: IconThemeData(color: Color.fromRGBO(221, 110, 66, 1)),
          primaryIconTheme: IconThemeData(color: Color.fromRGBO(221, 110, 66, 1))),
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
            child: HomeContainer(),
          ),
          Container(child: GamesContainer()),
          Container(child: GamesContainer()),
          Container(child: Profile()),
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
