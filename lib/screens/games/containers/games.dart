import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:matchpoint/models/game-information.dart';
import 'package:matchpoint/screens/games/components/create-game.dart';
import 'package:matchpoint/screens/games/components/games-list.dart';
import 'package:matchpoint/ui/loading-indicator.dart';
import 'package:provider/provider.dart';

class GamesContainer extends StatefulWidget {
  const GamesContainer({Key key}) : super(key: key);

  @override
  _GamesContainerState createState() => _GamesContainerState();
}

class _GamesContainerState extends State<GamesContainer>
    with TickerProviderStateMixin {
  TabController _tabController;
  List<Tab> tabList = List();
  FirebaseUser user;

  @override
  void initState() {
    tabList.add(Tab(
      text: 'Recommended',
    ));
    tabList.add(Tab(
      text: 'Upcoming',
    ));
    tabList.add(Tab(
      text: 'Invited',
    ));
    _tabController = TabController(vsync: this, length: tabList.length);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<GameInformation> _getUpcomingGames(List<DocumentSnapshot> games) {
    List<GameInformation> upcomingGames =
        games?.map((document) => GameInformation.fromJson(document))?.toList();

    upcomingGames = upcomingGames
        ?.where((game) => game?.players?.any((player) => player == user.uid))
        ?.toList();

    return upcomingGames ?? List<GameInformation>();
  }

  List<GameInformation> _getInvitedGames(List<DocumentSnapshot> games) {
    List<GameInformation> invitedGames =
        games?.map((document) => GameInformation.fromJson(document))?.toList();

    invitedGames = invitedGames
            ?.where((game) =>
                game?.invitedPlayers != null &&
                game.invitedPlayers.any((player) => player == user.uid))
            ?.toList() ??
        List<GameInformation>();

    return invitedGames;
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<FirebaseUser>(context);
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection('games').snapshots().take(20),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: LoadingIndicator());
          return Scaffold(
              appBar: AppBar(
                title: Center(
                    child: Text(FlutterI18n.translate(context, 'games.games'))),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
              floatingActionButton: floatingActionButton,
              body: Column(
                children: <Widget>[
                  gamesTabBar,
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: new TabBarView(
                        controller: _tabController,
                        children: <Widget>[
                          Center(
                            child: GamesList(
                                games: snapshot.data.documents
                                    .map((document) =>
                                        GameInformation.fromJson(document))
                                    .toList()),
                          ),
                          Center(
                            child: GamesList(
                                games:
                                    _getUpcomingGames(snapshot.data.documents)),
                          ),
                          Center(
                            child: GamesList(
                                games:
                                    _getInvitedGames(snapshot.data.documents)),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ));
        });
  }

  Widget get floatingActionButton {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (ctx) => CreateGame(
                pageTitle: "test",
              ),
            )));
  }

  Widget get gamesTabBar {
    return TabBar(
        indicatorColor: Color.fromRGBO(43, 59, 67, 1),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Color.fromRGBO(43, 59, 67, 1),
        controller: _tabController,
        tabs: tabList);
  }
}
