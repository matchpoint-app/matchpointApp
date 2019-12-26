import 'package:flutter/material.dart';
import 'package:matchpoint/screens/authenticate/login.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  Login loginPage;
  Widget currentPage;
  @override
void initState() {
  super.initState();
  currentPage = Login(this.callback);
}

void callback(Widget newPage) {
    setState(() {
      this.currentPage = newPage;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/Login.PNG"),
              fit: BoxFit.cover,
            ),
          ),
        child: currentPage,
      ),
    );
  }
}