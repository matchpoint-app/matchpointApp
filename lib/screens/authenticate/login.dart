import 'package:flutter/material.dart';
import 'package:matchpoint/routes.dart';
import 'package:matchpoint/screens/authenticate/auth-background.dart';
import 'package:matchpoint/services/auth.dart';

class Login extends StatefulWidget {
  Login();
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthService _auth = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isButtonDisabled = true;

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  void _fieldFocusChange(BuildContext ctx, FocusNode current, FocusNode next) {
    current.unfocus();
    FocusScope.of(ctx).requestFocus(next);
  }

  void submit() async {
    dynamic result = await _auth.signIn(
        emailController.value.text, passwordController.value.text);

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
          'Matchpoint',
          style: TextStyle(
            color: Colors.white,
            fontSize: 40,
            fontFamily: 'ModerneSans',
            decoration: TextDecoration.none,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: TextField(
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
                  labelText: "Email",
                  labelStyle: TextStyle(
                    color: Colors.white38,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60.0),
              child: TextField(
                focusNode: _passwordFocus,
                onSubmitted: (term) {
                  submit();
                },
                onChanged: (text) {
                  this._isButtonDisabled = false;
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
                  labelText: "Password",
                  labelStyle: TextStyle(
                    color: Colors.white38,
                  ),
                ),
              ),
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 60.0, vertical: 10),
                  child: FlatButton(
                    disabledColor: Colors.black38,
                    onPressed: submit,
                    color: Colors.black38,
                    padding: EdgeInsets.all(10),
                    child: Text('Login',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10),
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushReplacementNamed(Routes.Register);
                    },
                    color: Colors.black38,
                    padding: EdgeInsets.all(10),
                    child: Text('Register',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    ));
  }
}
