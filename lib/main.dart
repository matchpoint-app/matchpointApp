import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:matchpoint/app.dart';
import 'package:matchpoint/routes.dart';
import 'package:matchpoint/screens/authenticate/login.dart';
import 'package:matchpoint/screens/authenticate/register.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_map_location_picker/generated/i18n.dart'
    as location_picker;
import 'package:matchpoint/screens/games/containers/games.dart';
import 'package:matchpoint/screens/home/containers/home.dart';

void main() => runApp(MaterialApp(
      localizationsDelegates: [
        location_picker.S.delegate,
        FlutterI18nDelegate(path: 'assets/i18n', forcedLocale: Locale('en')),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('en'),
        Locale('sv'),
      ],
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
      home: MatchpointApp(),
      routes: <String, WidgetBuilder>{
        Routes.Login: (BuildContext context) => Login(),
        Routes.Register: (BuildContext context) => Register(),
        Routes.Home: (BuildContext context) => HomeContainer(),
        Routes.Games: (BuildContext context) => GamesContainer()
      },
    ));