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
          primarySwatch: Colors.deepOrange,
          primaryIconTheme: IconThemeData(color: Colors.black)),
      home: MatchpointApp(),
      routes: <String, WidgetBuilder>{
        Routes.Login: (BuildContext context) => Login(),
        Routes.Register: (BuildContext context) => Register(),
        Routes.Home: (BuildContext context) => HomeContainer(),
        Routes.Games: (BuildContext context) => GamesContainer()
      },
    ));
