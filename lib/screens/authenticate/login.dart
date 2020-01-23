import 'package:flutter/material.dart';
import 'package:flutter_i18n/flutter_i18n.dart';
import 'package:matchpoint/routes.dart';
import 'package:matchpoint/screens/authenticate/auth-background.dart';
import 'package:matchpoint/services/auth.dart';
import 'package:matchpoint/ui/loading-indicator.dart';

class Login extends StatefulWidget {
  Login();
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isLoading = false;

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  void _fieldFocusChange(BuildContext ctx, FocusNode current, FocusNode next) {
    current.unfocus();
    FocusScope.of(ctx).requestFocus(next);
  }

  void submit() async {
    setState(() => _isLoading = true);
    dynamic result = await _auth.signIn(
        emailController.value.text, passwordController.value.text);

    setState(() => _isLoading = false);
    if (result == null) {
      print('error');
      print(result);
    } else {
      Navigator.of(context).pushReplacementNamed(Routes.Home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          FlutterI18n.translate(context, "app.title"),
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontFamily: 'ModerneSans',
            decoration: TextDecoration.none,
          ),
        ),
        Center(
          child: Opacity(
            opacity: _isLoading ? 1 : 0,
            child: LoadingIndicator(),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: TextField(
                enabled: !_isLoading,
                focusNode: _emailFocus,
                onSubmitted: (term) {
                  _fieldFocusChange(context, _emailFocus, _passwordFocus);
                },
                autocorrect: false,
                enableSuggestions: false,
                controller: emailController,
                style: TextStyle(color: Colors.white),
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  focusedBorder: const UnderlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 0.0),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 0.0),
                  ),
                  labelText: FlutterI18n.translate(context, "common.email"),
                  labelStyle: TextStyle(
                    color: Colors.white38,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: TextField(
                enabled: !_isLoading,
                focusNode: _passwordFocus,
                onSubmitted: (term) {
                  submit();
                },
                autocorrect: false,
                obscureText: true,
                enableSuggestions: false,
                controller: passwordController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  focusedBorder: const UnderlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 0.0),
                  ),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 0.0),
                  ),
                  labelText: FlutterI18n.translate(context, "common.password"),
                  labelStyle: TextStyle(
                    color: Colors.white38,
                  ),
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(60, 40, 60, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FlatButton(
                      disabledColor: Colors.black38,
                      onPressed: _isLoading ? null : submit,
                      color: Colors.black38,
                      padding: EdgeInsets.all(10),
                      child: Text(
                          FlutterI18n.translate(context, "common.login"),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                    FlatButton(
                      onPressed: () => _isLoading
                          ? null
                          : Navigator.of(context)
                              .pushReplacementNamed(Routes.Register),
                      color: Colors.black38,
                      padding: EdgeInsets.all(10),
                      child: Text(
                          FlutterI18n.translate(context, "common.register"),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ],
                )),
          ],
        ),
      ],
    ));
  }
}
