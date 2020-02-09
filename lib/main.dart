import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_map_location_picker/generated/i18n.dart'
    as location_picker;
import 'package:matchpoint/app.dart';
import 'package:matchpoint/routes.dart';
import 'package:matchpoint/screens/authenticate/containers/login-splash.dart';
import 'package:matchpoint/screens/games/containers/games.dart';
import 'package:matchpoint/screens/home/containers/home.dart';
import 'package:matchpoint/screens/profile/profile.dart';
import 'package:matchpoint/screens/social/containers/chat.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  return runApp(MultiProvider(
      providers: [
        StreamProvider<FirebaseUser>.value(
            value: FirebaseAuth.instance.onAuthStateChanged),
      ],
      child: MaterialApp(
        localizationsDelegates: [
          location_picker.S.delegate,
          FlutterI18nDelegate(path: 'assets/i18n', forcedLocale: Locale('en')),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const <Locale>[
          Locale('en'),
          Locale('sv'),
        ],
        theme: ThemeData(
            primaryColor: Color.fromRGBO(43, 59, 67, 1),
            appBarTheme: AppBarTheme(
                iconTheme:
                    IconThemeData(color: Color.fromRGBO(234, 234, 234, 1)),
                actionsIconTheme:
                    IconThemeData(color: Color.fromRGBO(234, 234, 234, 1))),
            scaffoldBackgroundColor: Color.fromRGBO(234, 234, 234, 1),
            primaryTextTheme: TextTheme(
              title: TextStyle(color: Color.fromRGBO(234, 234, 234, 1)),
              subhead: TextStyle(color: Color.fromRGBO(43, 59, 67, 1)),
            ),
            textTheme: TextTheme(
              body1: TextStyle(color: Color.fromRGBO(43, 59, 67, 1)),
              body2: TextStyle(color: Color.fromRGBO(43, 59, 67, 1)),
              subhead: TextStyle(color: Color.fromRGBO(43, 59, 67, 1)),
            ),
            floatingActionButtonTheme: FloatingActionButtonThemeData(
                backgroundColor: Color.fromRGBO(221, 110, 66, 1),
                foregroundColor: Color.fromRGBO(234, 234, 234, 1)),
            iconTheme: IconThemeData(color: Color.fromRGBO(221, 110, 66, 1)),
            primaryIconTheme:
                IconThemeData(color: Color.fromRGBO(221, 110, 66, 1))),
        home: LoginSplash(),
        routes: <String, WidgetBuilder>{
          Routes.Login: (BuildContext context) => LoginSplash(),
          Routes.App: (BuildContext context) => MatchpointApp(),
          Routes.Home: (BuildContext context) => HomeContainer(),
          Routes.Games: (BuildContext context) => GamesContainer(),
          Routes.Chat: (BuildContext context) => ChatContainer(),
          Routes.Profile: (BuildContext context) => ProfileContainer()
        },
      )));
}
