import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:matchpoint/routes.dart';
import 'package:matchpoint/screens/authenticate/components/auth-background.dart';
import 'package:matchpoint/screens/authenticate/components/login.dart';
import 'package:matchpoint/services/auth-google.dart';
import 'package:matchpoint/ui/animations/slight-fade.dart';
import 'package:matchpoint/ui/loading-indicator.dart';
import 'package:provider/provider.dart';

class LoginSplash extends StatefulWidget {
  LoginSplash();
  @override
  _LoginSplashState createState() => _LoginSplashState();
}

class _LoginSplashState extends State<LoginSplash> {
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.onAuthStateChanged.first.then(((user) async {
      if (user != null) {
        user.getIdToken(refresh: true).then((idTokenResult) {
          Future.delayed(Duration(milliseconds: 2500),
              () => Navigator.of(context).pushReplacementNamed(Routes.App));
        }).catchError((err) {
          if (err is PlatformException) {
            FirebaseAuth.instance.signOut();
          }
        });
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SlideFadeTransition(
            child: Text(
          FlutterI18n.translate(context, "app.title"),
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontFamily: 'ModerneSans',
            decoration: TextDecoration.none,
          ),
        )),
        Center(
          child: Opacity(
            opacity: _isLoading ? 1 : 0,
            child: LoadingIndicator(),
          ),
        ),
        _loginOrWelcome()
      ],
    ));
  }

  Widget _loginOrWelcome() {
    final user = Provider.of<FirebaseUser>(context);
    bool loggedIn = user != null;

    return loggedIn
        ? Text(
            "Welcome ${user.displayName}",
            style: TextStyle(color: Colors.white, fontSize: 24),
          )
        : Login(
            onGoogleAuthPress: () => _loginWithGoogle(),
          );
  }

  void _loginWithGoogle() async {
    setState(() => _isLoading = true);
    var user = await GoogleAuth.signInWithGoogle();
    setState(() => _isLoading = false);
    if (user != null) {
      Navigator.of(context).pushReplacementNamed(Routes.App);
    }
  }
}
