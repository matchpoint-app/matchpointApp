import 'package:flutter/material.dart';
import 'package:matchpoint/routes.dart';
import 'package:matchpoint/screens/authenticate/auth-background.dart';
import 'package:matchpoint/services/auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60.0),
          child: TextField(
            autocorrect: false,
            enableSuggestions: false,
            controller: emailController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 0.0),
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
            autocorrect: false,
            obscureText: true,
            enableSuggestions: false,
            controller: passwordController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              enabledBorder: const UnderlineInputBorder(
                borderSide: const BorderSide(color: Colors.white, width: 0.0),
              ),
              labelText: "Password",
              labelStyle: TextStyle(
                color: Colors.white38,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60.0, vertical: 10),
          child: FlatButton(
            disabledTextColor: Colors.white38,
            onPressed: () async {
              dynamic result = await _auth.register(
                  emailController.value.text, passwordController.value.text);

              if (result == null) {
                print('error');
              } else {
                Navigator.of(context).pushReplacementNamed(Routes.Login);
              }
            },
            color: Colors.black38,
            padding: EdgeInsets.all(10),
            child: Text('Register',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    ));
  }
}
