import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({@required this.child, Key key}) : super(key: key);
  final Widget child;

  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/Login.PNG"),
            fit: BoxFit.cover,
          ),
        ),
        child: child,
      ),
    );
  }
}
