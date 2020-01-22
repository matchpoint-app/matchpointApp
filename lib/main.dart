import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n_delegate.dart';
import 'package:matchpoint/routes.dart';
import 'package:matchpoint/screens/authenticate/login.dart';
import 'package:matchpoint/screens/authenticate/register.dart';
import 'package:matchpoint/screens/home/home.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_map_location_picker/generated/i18n.dart'
    as location_picker;

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
      initialRoute: Routes.Login,
      routes: <String, WidgetBuilder>{
        Routes.Home: (BuildContext context) => Home(),
        Routes.Login: (BuildContext context) => Login(),
        Routes.Register: (BuildContext context) => Register()
      },
    ));
