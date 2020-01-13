import 'package:flutter/material.dart';
import 'package:matchpoint/routes.dart';
import 'package:matchpoint/screens/authenticate/login.dart';
import 'package:matchpoint/screens/authenticate/register.dart';
import 'package:matchpoint/screens/home/home.dart';

void main() => runApp(MaterialApp(
      initialRoute: Routes.Login,
      routes: <String, WidgetBuilder>{
        Routes.Home: (BuildContext context) => Home(),
        Routes.Login: (BuildContext context) => Login(),
        Routes.Register: (BuildContext context) => Register()
      },
    ));
