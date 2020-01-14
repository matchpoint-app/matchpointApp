import 'package:flutter/material.dart';
import 'package:matchpoint/screens/games/games.dart';
import 'package:matchpoint/ui/layout.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Layout(pageTitle: 'Home', body: Games());
  }
}
